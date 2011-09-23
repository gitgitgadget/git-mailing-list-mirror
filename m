From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 3/6] branch: teach --edit-description option
Date: Fri, 23 Sep 2011 19:47:21 +1000
Message-ID: <20110923094721.GA8397@duynguyen-vnpc>
References: <7vy5xi4y3m.fsf@alter.siamese.dyndns.org>
 <1316729362-7714-1-git-send-email-gitster@pobox.com>
 <1316729362-7714-4-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 23 11:47:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R72M7-0004L0-Nh
	for gcvg-git-2@lo.gmane.org; Fri, 23 Sep 2011 11:47:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752775Ab1IWJrd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Sep 2011 05:47:33 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:42928 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752728Ab1IWJrc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Sep 2011 05:47:32 -0400
Received: by yxl31 with SMTP id 31so2545459yxl.19
        for <git@vger.kernel.org>; Fri, 23 Sep 2011 02:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=242MURV+qmI/BwIEU1ZqyisoW0DyyaJohor7wdkb9F0=;
        b=ZrohDHo45X9vRyRFF8VocYC6MwfJ0XYZACF9T6h8I9Y627Lq9KWefzl7CdKG9JxXAN
         B9CVs7ej54xyfzJVXIG1uXDz0Lv9Qlv2a8h0alBGt/1XPuff2vm1nK2iedNQ/Q0rBG/z
         sXZTt7HE8g0PeJdGJFHXJ+45fzfnOj10YvMRg=
Received: by 10.236.176.65 with SMTP id a41mr20487896yhm.72.1316771252016;
        Fri, 23 Sep 2011 02:47:32 -0700 (PDT)
Received: from pclouds@gmail.com (220-244-161-237.static.tpgi.com.au. [220.244.161.237])
        by mx.google.com with ESMTPS id n18sm8412874yhi.14.2011.09.23.02.47.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 23 Sep 2011 02:47:30 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 23 Sep 2011 19:47:21 +1000
Content-Disposition: inline
In-Reply-To: <1316729362-7714-4-git-send-email-gitster@pobox.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181952>

On Thu, Sep 22, 2011 at 03:09:19PM -0700, Junio C Hamano wrote:
> +	if (launch_editor(git_path(edit_description), &buf, NULL)) {
> +		strbuf_release(&buf);
> +		return -1;
> +	}
> +	stripspace(&buf, 1);
> +
> +	strbuf_addf(&name, "branch.%s.description", branch_name);
> +	status =3D git_config_set(name.buf, buf.buf);

I suppose a Windows editor mave save the description with \r\n
ending. Perhaps a patch like this to avoid messing up config file?

--8<--
Subject: [PATCH] config: quote \r in value

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 config.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/config.c b/config.c
index 4183f80..2e238ac 100644
--- a/config.c
+++ b/config.c
@@ -165,6 +165,9 @@ static char *parse_value(void)
 			case 'b':
 				c =3D '\b';
 				break;
+			case 'r':
+				c =3D '\r';
+				break;
 			case 'n':
 				c =3D '\n';
 				break;
@@ -1048,6 +1051,9 @@ static int store_write_pair(int fd, const char *k=
ey, const char *value)
=20
 	for (i =3D 0; value[i]; i++)
 		switch (value[i]) {
+		case '\r':
+			strbuf_addstr(&sb, "\\r");
+			break;
 		case '\n':
 			strbuf_addstr(&sb, "\\n");
 			break;
--=20
1.7.3.1.256.g2539c.dirty
--8<--
