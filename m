From: Junio C Hamano <gitster@pobox.com>
Subject: Re* Bug report: reset -p HEAD
Date: Thu, 24 Oct 2013 20:40:13 -0700
Message-ID: <xmqqvc0mj9wi.fsf_-_@gitster.dls.corp.google.com>
References: <CAPWpf+wi0zH2sOnuqiZuKkf+kC0RMug_ASb-J-TGGLd2RFT1wg@mail.gmail.com>
	<CAPWpf+xqutvhq1jyVkxr6LyKsANTCS6M=vj5XY=EgUfiS3Z8xg@mail.gmail.com>
	<CAPWpf+x5KUjD2K81pJAsV_XuPkd=BT06qPjvr8s7tEe5YqBt=w@mail.gmail.com>
	<CAPWpf+zkA68pzR3qx5xma8BNiONwt5o8iNba0x8fmmiDAWpHuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git mailing list <git@vger.kernel.org>,
	Martin von Zweigbergk <martinvonz@gmail.com>
To: Maarten de Vries <maarten@de-vri.es>
X-From: git-owner@vger.kernel.org Fri Oct 25 05:40:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZYGH-0001NW-Jg
	for gcvg-git-2@plane.gmane.org; Fri, 25 Oct 2013 05:40:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755383Ab3JYDkT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Oct 2013 23:40:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47180 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754310Ab3JYDkR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Oct 2013 23:40:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A063F46A86;
	Fri, 25 Oct 2013 03:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qXXAKGyZuaoBdkqGBWAUKghsdYE=; b=RSG71O
	aBUg+lRw9EgG/aXdXibCYR0kTNFXvFEHUUqqm80fBT/xIJtf6Vxuev08tau4jG1C
	S190ZFCkHTuqPXsLytafUXMSxzBBakfolTrzqWJOIk46Kdx2oSSSFLXTgEdkcb26
	Y5iNr6tHzMPCGnwxW7tOBY2WlmCLfAj+H/reY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=R0rx2STeEFyQT9AwlU6GLDxfPFSUkp0c
	Y4oGH7zmRxgq0RozN6IlVVc+3gH0FG/g2pP/g86yJPAFBaNUAj0K14lPbajQVFXv
	8Vrkn4P68nPLxzbp4gpUYzNS+KQTz4cr51GwjHzvRUCYLJ16xqTDhBpY9KOkOWzM
	qr/8eYm20dw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 92D9D46A84;
	Fri, 25 Oct 2013 03:40:16 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CC97246A7C;
	Fri, 25 Oct 2013 03:40:15 +0000 (UTC)
In-Reply-To: <CAPWpf+zkA68pzR3qx5xma8BNiONwt5o8iNba0x8fmmiDAWpHuw@mail.gmail.com>
	(Maarten de Vries's message of "Fri, 25 Oct 2013 01:16:55 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 29607FA8-3D27-11E3-B1EF-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236650>

Maarten de Vries <maarten@de-vri.es> writes:

> Some more info: It used to work as intended. Using a bisect shows it
> has been broken by commit 166ec2e9.

Thanks.

A knee-jerk change without thinking what side-effect it has for you
to try out.

 builtin/reset.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index f2f9d55..a3088d9 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -304,7 +304,10 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 	if (patch_mode) {
 		if (reset_type != NONE)
 			die(_("--patch is incompatible with --{hard,mixed,soft}"));
-		return run_add_interactive(sha1_to_hex(sha1), "--patch=reset", &pathspec);
+		return run_add_interactive(
+			(unborn || strcmp(rev, "HEAD"))
+			? sha1_to_hex(sha1)
+			: "HEAD", "--patch=reset", &pathspec);
 	}
 
 	/* git reset tree [--] paths... can be used to
