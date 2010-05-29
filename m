From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH v2 3/3] commit::print_summary(): set rev_info.always_show_header 
	to 1
Date: Sat, 29 May 2010 09:41:49 +0800
Message-ID: <AANLkTim3hT-kloICHNeuodeisYUqccLhEDq_5rCeBRSC@mail.gmail.com>
References: <1274694452-4200-1-git-send-email-rctay89@gmail.com>
	<1274974492-4692-1-git-send-email-rctay89@gmail.com>
	<1274974492-4692-2-git-send-email-rctay89@gmail.com>
	<1274974492-4692-3-git-send-email-rctay89@gmail.com>
	<1274974492-4692-4-git-send-email-rctay89@gmail.com>
	<7vd3wf5x7n.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 29 03:41:57 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OIB3j-0004hd-W2
	for gcvg-git-2@lo.gmane.org; Sat, 29 May 2010 03:41:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752710Ab0E2Blv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 May 2010 21:41:51 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:47034 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751327Ab0E2Blu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 May 2010 21:41:50 -0400
Received: by gwaa12 with SMTP id a12so1495618gwa.19
        for <git@vger.kernel.org>; Fri, 28 May 2010 18:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=2YcC6OHWCBRGGrsRaLC3WJicRiKaxe2TJCw5FlaqCFg=;
        b=dFxii5FqU1aE70c5RdJ/3EJ2/XMTD5UtznCenl5+b0nA7ig7O1IW7LBdbuo7NQU2qB
         FYdAxfNqoKc9a5ixXRCMQLJekaCTQDasPd63MkqwCnpa6RtJdeDbTZySkAoGWY4++tYZ
         AUgF+f2AkGBChJBa0v5CnoH6gHwnEhhkDJHaQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=C9lcMCpQ5mdWcXrJhXRbQS80d5iwK90fQmf512Oz0KapMxmmUab9NP27VMxWTirh8x
         A2C0YpAVVCPaLdBxya4CxxrsEEkbTc+NTeCfso1xvY+kIEDlfauXKE700uKGD4VQHNpy
         Iqs8RMUlhM6ZqPqV0eXuHfm5lTlp0iejPQxIw=
Received: by 10.231.194.194 with SMTP id dz2mr1350264ibb.74.1275097309059; 
	Fri, 28 May 2010 18:41:49 -0700 (PDT)
Received: by 10.231.33.12 with HTTP; Fri, 28 May 2010 18:41:49 -0700 (PDT)
In-Reply-To: <7vd3wf5x7n.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147948>

On Sat, May 29, 2010 at 9:10 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Tay Ray Chuan <rctay89@gmail.com> writes:
>> Quoting log-tree.c:560:
>>
>> =A0 =A0 =A0 shown =3D log_tree_diff(opt, commit, &log);
>> =A0 =A0 =A0 if (!shown && opt->loginfo && opt->always_show_header) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 log.parent =3D NULL;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 show_log(opt);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 shown =3D 1;
>> =A0 =A0 =A0 }
>>
>> This is the only area that always_show_header is checked, so the
>> setting of this flag should only affect this area.
>
> Hmm, but also setting this flag would affect anything that changes
> behaviour depending on the value of log.parent, no?

A cursory look at log-tree.c leads me to believe only show_log() cares
about log.parent.

In any case, if you look a few more lines up, you would notice another
log.parent =3D NULL:

@552
	struct log_info log;
	int shown;

	log.commit =3D commit;
	log.parent =3D NULL;
	opt->loginfo =3D &log;

	shown =3D log_tree_diff(opt, commit, &log);
	if (!shown && opt->loginfo && opt->always_show_header) {
		log.parent =3D NULL;
		show_log(opt);
		shown =3D 1;
	}

Therefore, I suspect that log.parent =3D NULL is a kind of
initialization for show_log() (log_tree_diff() does call show_log()
too).

>> + =A0 =A0 if (!log_tree_commit(&rev, commit))
>> + =A0 =A0 =A0 =A0 =A0 =A0 die("unable to print summary");
>
> When always_show_header is set, what are the situations where
> log_tree_commit() might return false? =A0I think your fix depends on =
the
> fact that it will never return false (which I think is a correct thin=
g to
> assume---after all that is what "always_show" means ;-).

Based on my reading, I can't think of any.

--=20
Cheers,
Ray Chuan
