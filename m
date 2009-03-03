From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH v3] send-email: add --confirm option and configuration 
	setting
Date: Tue, 3 Mar 2009 19:05:47 +0100
Message-ID: <36ca99e90903031005g3d54436cs486133a340c1eec1@mail.gmail.com>
References: <7v1vtfjpad.fsf@gitster.siamese.dyndns.org>
	 <1236055938-65407-1-git-send-email-jaysoffian@gmail.com>
	 <36ca99e90903030354j33de0313n41d8a95ff898798b@mail.gmail.com>
	 <76718490903030822j690cb97blea292d391c0d0112@mail.gmail.com>
	 <7vvdqqblij.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 03 19:07:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeZ1T-0005bn-U3
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 19:07:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752064AbZCCSFv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Mar 2009 13:05:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751416AbZCCSFv
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 13:05:51 -0500
Received: from ey-out-2122.google.com ([74.125.78.25]:27806 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750868AbZCCSFu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Mar 2009 13:05:50 -0500
Received: by ey-out-2122.google.com with SMTP id 25so624342eya.37
        for <git@vger.kernel.org>; Tue, 03 Mar 2009 10:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=K9rv7fffPqAcQH2vS0mK8J0GGq+8euzvZoNu3UjvEho=;
        b=hQYuXMziBBpuy6z/DE8ncvo+AfIO9o9mG3hOkcegbx/cCQ3Wid0m3kxFsifIucJuS8
         u4orOgVzAw+1eH24/ym+GhwbzxACckP8mdPtM8a1ZzK1DuS1dGmMDMVq4oTZKI3LZh5w
         9o39i7hVnS/zIXf0eEg+C0W5oo000pPImXVkc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ouvSywFnVb8u7hXAR3c9wNbb7SKmibk3D+VWuVfqaDJAO3cbfXCQ8MxTJR8Jb+uHsq
         Zyo5V42qDBMGaYNaayadNEfCmPipoH8+SOHPfFP9cQWXKfEsXZsbFefnYaWemU0cnsx/
         4heRzASxB4hkXix6T3qcgz7GUF8EkiuUJDEUg=
Received: by 10.210.11.17 with SMTP id 17mr5861296ebk.32.1236103547734; Tue, 
	03 Mar 2009 10:05:47 -0800 (PST)
In-Reply-To: <7vvdqqblij.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112138>

On Tue, Mar 3, 2009 at 17:48, Junio C Hamano <gitster@pobox.com> wrote:
> Jay Soffian <jaysoffian@gmail.com> writes:
>
>> On Tue, Mar 3, 2009 at 6:54 AM, Bert Wesarg <bert.wesarg@googlemail.=
com> wrote:
>>> On Tue, Mar 3, 2009 at 05:52, Jay Soffian <jaysoffian@gmail.com> wr=
ote:
>>>> diff --git a/git-send-email.perl b/git-send-email.perl
>>>> index adf7ecb..57127aa 100755
>>>> --- a/git-send-email.perl
>>>> +++ b/git-send-email.perl
>>>> @@ -837,6 +837,37 @@ X-Mailer: git-send-email $gitversion
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0unshift (@sendmail_parameters,
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0'-f', $raw_from) if(defined $envelope_sender);
>>>>
>>>> + =C2=A0 =C2=A0 =C2=A0 if ($needs_confirm && !$dry_run) {
>>> So, the output is now differnt with and without --dry-run?
>>
>> There doesn't seem to be any point in having the user confirm before
>> sending the message if the message is not actually going to be sent.
>> Am I missing something?
>
> I do not think you are missing anything.
>
> IIRC, the --dry-run mode shows more clearly to whom you would be CC'i=
ng
> the messages; in other words, the behaviour would be different, but i=
t
> gives an uninteractive way to confirm, and not pausing for confirmati=
on is
> a good thing.
>
Just to clarify: A user who runs a --dry-run before every sending
(like me) would check the Cc list anyway (like me), so he either would
have sendmail.confirm=3Dnever in the config, so that he will not
bothered by send-email while sending or he sees some Cc's that he
don't want and can remove them in the sending process.

Ok, than I'm fine with this.

Regards,
Bert
