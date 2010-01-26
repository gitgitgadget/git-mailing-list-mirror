From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: git-format-patch should include a checksum
Date: Wed, 27 Jan 2010 00:15:28 +0100
Message-ID: <fabb9a1e1001261515w44ccf7a4le6a49724164e902c@mail.gmail.com>
References: <871vhcmr5b.fsf@trurl.pps.jussieu.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Juliusz Chroboczek <jch@pps.jussieu.fr>
X-From: git-owner@vger.kernel.org Wed Jan 27 00:15:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZudV-0005DU-Rc
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jan 2010 00:15:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752777Ab0AZXPt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Jan 2010 18:15:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752547Ab0AZXPt
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jan 2010 18:15:49 -0500
Received: from mail-pw0-f42.google.com ([209.85.160.42]:56090 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751628Ab0AZXPt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Jan 2010 18:15:49 -0500
Received: by pwi21 with SMTP id 21so3319092pwi.21
        for <git@vger.kernel.org>; Tue, 26 Jan 2010 15:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=pY3DgWwpdi493lLFEyAov3yjhjqaYTpDDGrUwE23HHo=;
        b=cRxINfzWSEwA8kwoVxEOwxqzAyFV5T/P8OFur0mqcnENRGaAUJEWWZtKelcOqzXKCZ
         HN6Qfb3gw73tdJXq12GqK+iuKILLoOFAP/JVsy+s7vGt0UiqZirxHxo+WmGUXjwNZrYy
         HxGseYhi/EjUAYZ+cecpvtSxDwZwiKbJUfw1I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=dxiz7FZ+FCNaouNJ9InAQ64RIXxUkxO8qUD4zETt0/Ngyo6aAD05+a7n51EoF7dzUd
         P4g760G2Co2XXBGJBygrSm+oZPfMs/RIUev5ucCWrsgbi13naqJSzOGduJBPlUjJ7FiA
         ox+S6DoqHcpjTl5UhSR2VF+uQQpGEOqEoDRS4=
Received: by 10.143.24.15 with SMTP id b15mr5984293wfj.41.1264547748079; Tue, 
	26 Jan 2010 15:15:48 -0800 (PST)
In-Reply-To: <871vhcmr5b.fsf@trurl.pps.jussieu.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138086>

Heya,

On Tue, Jan 26, 2010 at 23:34, Juliusz Chroboczek <jch@pps.jussieu.fr> =
wrote:
> I'm seeing Git patches being corrupted by mailers and still apply
> correctly. =A0It would be great if git-format-patch could include a h=
ash
> of the patch body (and commit message); git-am should check the hash,
> and refuse to commit if the patch was corrupted (--force should overr=
ide
> that, of course).

Sounds like a good idea, have a look at cmd_format_patch in
builtin-log.c. Assuming you want to add the hash as a X- mail header
(e.g. X-Git-Message-Hash), you should probably add it before line 1019
(where rev.extra_headers is set to the current contents of 'buf'). For
the hash itself have a look at git_SHA1_{Init,Update,Final} in various
files, csum-file.c would seem like an excellent candidate, as it
writes a sha1-summed file, which is sortof what you want to do.

=46or the git-am part look at 'git-am.sh', you should have checking
logic warn only at first, and add a configuration option that allows
enforcing it and warn when the option isn't set, instructing the user
how to configure the option, see warn_unconfigured_deny_msg in
builtin-receive-pack.c. A few releases from now we can set it from
warn to abort (or deny, whatever the enforcing option is called).

Good luck!

--=20
Cheers,

Sverre Rabbelier
