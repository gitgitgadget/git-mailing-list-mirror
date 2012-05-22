From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 2/7] sequencer: release a strbuf used in save_head()
Date: Tue, 22 May 2012 09:42:09 +0530
Message-ID: <CALkWK0m9F6EU43v0HbJxWUVtHTiw+ZvjCjwqbSVdQfomb6f4Aw@mail.gmail.com>
References: <20120521143309.1911.94302.chriscool@tuxfamily.org> <20120521145610.1911.61154.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Nick Bowler <nbowler@elliptictech.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Tue May 22 06:12:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWgSa-0002St-FV
	for gcvg-git-2@plane.gmane.org; Tue, 22 May 2012 06:12:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750892Ab2EVEMc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 May 2012 00:12:32 -0400
Received: from mail-wg0-f42.google.com ([74.125.82.42]:49173 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750733Ab2EVEMb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 May 2012 00:12:31 -0400
Received: by wgbds11 with SMTP id ds11so3281635wgb.1
        for <git@vger.kernel.org>; Mon, 21 May 2012 21:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=4MkRLBFf45wChRtCf+oDXS468IO65AthyroyKmGbCb0=;
        b=sVjzDBL+f00/wcHXG/B45YkYx/KO8wxA7U0GoYcS7lDwnOy3FP/VvQIACDZaQNqYZs
         T45UQ0RNKQxWtr6t8GLVKZWQ/hXILNENIQRrEdN7jhFF27gD445NndKAFbK015vt2ATh
         lBE3Z05DtT2DSYrTmX8UILUgsZFgKb2K9Eb0/7/4v8Q4RWwSDUY7LrpK0scwyUEbfXR5
         xic9yIKYOnbEp5uoNuCin/tEcnxCQIfXUMF1q0hA+kr4Kd0YkVG5LWt13gRVBAxyBPzH
         fhUrF09BSSO8TtwD40wji+CO/8dUi6WfUH+KETJ52vzGod5BB72TmwSNZ/h38fdkfUBU
         3n2w==
Received: by 10.216.218.219 with SMTP id k69mr647122wep.123.1337659950210;
 Mon, 21 May 2012 21:12:30 -0700 (PDT)
Received: by 10.216.68.10 with HTTP; Mon, 21 May 2012 21:12:09 -0700 (PDT)
In-Reply-To: <20120521145610.1911.61154.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198167>

Hi Christian,

Christian Couder wrote:
> diff --git a/sequencer.c b/sequencer.c
> index 762c527..ad1bbea 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -741,6 +741,7 @@ static void save_head(const char *head)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0die_errno(_("C=
ould not write to %s"), head_file);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (commit_lock_file(&head_lock) < 0)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0die(_("Error w=
rapping up %s."), head_file);
> + =C2=A0 =C2=A0 =C2=A0 strbuf_release(&buf);
> =C2=A0}
>
> =C2=A0static int reset_for_rollback(const unsigned char *sha1)

Thanks.  Shouldn't we be polluting the die() pathways with this
strbuf_release(&buf) the way save_todo() does it consistently?

	if (write_in_full(fd, buf.buf, buf.len) < 0) {
		strbuf_release(&buf);
		die_errno(_("Could not write to %s"), todo_file);
	}
	if (commit_lock_file(&todo_lock) < 0) {
		strbuf_release(&buf);
		die(_("Error wrapping up %s."), todo_file);
	}
	strbuf_release(&buf);

Ram
