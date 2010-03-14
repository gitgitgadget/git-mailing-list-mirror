From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-send-email.perl - Fix 550 EHLO argument does not
 match calling host
Date: Sat, 13 Mar 2010 22:28:09 -0800
Message-ID: <7vtysjs9hi.fsf@alter.siamese.dyndns.org>
References: <4B97C157.4020806@gmail.com>
 <20100311081213.GA13575@sigill.intra.peff.net>
 <20100311083148.GA13786@sigill.intra.peff.net>
 <7vaaueziv8.fsf@alter.siamese.dyndns.org> <4B9A74CA.4080507@gmail.com>
 <7vy6hxnnfx.fsf@alter.siamese.dyndns.org> <87bpesi0om.fsf_-_@jondo.cante.net>
 <7vfx433l9x.fsf@alter.siamese.dyndns.org> <87eijng4hy.fsf@jondo.cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Sun Mar 14 07:28:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NqhJH-0003M5-4P
	for gcvg-git-2@lo.gmane.org; Sun, 14 Mar 2010 07:28:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752173Ab0CNG2R convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Mar 2010 01:28:17 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:54499 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752104Ab0CNG2R convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Mar 2010 01:28:17 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BF2EBA1432;
	Sun, 14 Mar 2010 01:28:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=x0UmGavDu6e3PYxpo59FsgIHw
	Qg=; b=dZFK945ezEi+r1q7W/b4PcFHX5veGYCo5Fz3j6GyYYzAIvCLByRLxfe6n
	GRBWfLTRV/hWDCjdWykN/HUCz7C4JtEcMS0MIHvYnWW9d2mR/nejQ68dE/pWzBb7
	10d0Hfme/f87wiFq4akTN6cnLZOn9vBl45xaH6yQutSB5HcBT0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=yhtM/zEYS2J2l8Zs5Tw
	4Ucf/EXWe5ae/bnbw23ip+zy9O/tTpkatnrkK3E7ZtF5VUGQAu090s+p1kCirKMT
	qIYTjofJTNux/S5bAt3NVgYMmAQNZd+sgmCb4k5vS5VEgv+ohL6WDTU9tA4I5aDm
	0vCb1Ss4ZXEFAgx8waA/lvyg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 92AC7A142F;
	Sun, 14 Mar 2010 01:28:13 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A0201A142D; Sun, 14 Mar
 2010 01:28:10 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C47B58A2-2F32-11DF-B48E-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142126>

Jari Aalto <jari.aalto@cante.net> writes:

>>  - You are trying to improve the chance that $smtp_server likes the =
name
>>    your side identifies as; what does it have to do with your local
>>    "mailhost" or "localhost" listening to the SMTP port?  These loca=
l MTA
>>    may be configured for local-only delivery after all.
>
> There is now explicit option to set the name with option --mail-domai=
n.
> Hope this address the issue.

Not quite.  Imagine if you were a maintainer of a system who received a
patch that looks like adding a piece of code that computes random rubbi=
sh.

    sub a_function () {
	compute some value that looked not so useful nor reliable;
        return it to be used;
    }

When you ask the contributor why the code computes and uses it, the
contributor sends an updated patch that lets the user override the logi=
c
and specify the exact value to be used.  That is:

    sub a_function () {
+	if (the user gave a value)
+        	return that value;
	compute some value that looked not so useful nor reliable;
        return it to be used;
    }

Does that updated patch answer the question you asked?

Configurability does not alleviate the puzzlement about the logic. A
better explanation would be to describe how the computation produces
reliable and correct value for the most sane installations; then the us=
er
configurability becomes only "just in case" way to give them the last
resort.

If you don't have a good explanation, the patch should instead be like
this:

    sub a_function () {
-	compute some value that looked not so useful nor reliable;
-       return it to be used;
+	if (the user gave a value)
+        	return that value;
+	die "please configure me";
    }

So please explain why asking your local MTA (either mailhost or localho=
st)
how it is configured to identify to other MTA is a good way to obtain t=
he
HELO domain you should give $smtp_server.  Your answer could be "I expe=
ct
that most people use $smtp_server set to 'mailhost' or 'localhost' and
have the MTA configured to talk with the outside world." (which by the =
way
I do not think is true for most people).  Or it could be "Xsmtp MTA tha=
t
is used by many people to send out mails through their ISP's mailserver
uses the same trick to solve this issue".

Side note.  Apparently this seems to be a common issue.  For example,
msmtp has this configurable via command line and configuration option:

   domain argument
          Use  this  command to set the argument of the SMTP EHLO (or L=
MTP
          LHLO) command.  The default is localhost (stupid, but  workin=
g).
          Possible  choices  are  the  domain  part  of  your mail addr=
ess
          (provider.example for joe@provider.example) or the fully  qua=
li=E2=80=90
          fied domain name of your host (if available).

Interestingly, one of the suggestions above is to derive it from the Fr=
om
address.

In any case, I want to hear your justification.

> +    --smtp-domain           <str>  * The domain name sent to HELO/EH=
LO handshake

I think this addition makes sense. I suspect that we would also want to
have sendemail.smtpdomain configuration variable.  They of course need =
to
be documented.

> @@ -131,6 +132,7 @@ my $have_email_valid =3D eval { require Email::Va=
lid; 1 };
>  my $have_mail_address =3D eval { require Mail::Address; 1 };
>  my $smtp;
>  my $auth;
> +my $MAIL_DOMAIN;			# See maildomain()

Why uppercase?  The lifetime rule for this looks exactly the same as
existing $smtp to me, so it would be more sensible to spell it in
lowercase, $mail_domain.

> +sub maildomain
> +{
> +        return $MAIL_DOMAIN if $MAIL_DOMAIN;
> +
> +	my $maildomain;

Looks like a funny indent here...

> +	eval "use Net::SMTP";
> +
> +	unless ( $@ ) {
> +		for my $host ( qw(mailhost localhost) ) {

Please drop extra SP immediately after '(' and before ')'; they are
distracting.

But as I already said, I tend to think the logic implemented by this pa=
rt
is of dubious validity.

> @@ -917,6 +962,8 @@ X-Mailer: git-send-email $gitversion
>  		}
>  	}
> =20
> +	my $maildomain;
> +
>  	if ($dry_run) {
>  		# We don't want to send the email.
>  	} elsif ($smtp_server =3D~ m#^/#) {
> @@ -936,13 +983,18 @@ X-Mailer: git-send-email $gitversion
> ...
> +			$maildomain =3D maildomain() || "localhost.localdomain";
> +			$smtp ||=3D Net::SMTP::SSL->new($smtp_server,
> +						      Hello =3D> $maildomain,
> +						      Port =3D> $smtp_server_port);

Why not use the same structure as how lifetime is defined for $smtp
variable?  IOW,

			$mail_domain || =3D maildomain();
			$smtp ||=3D ...

without an extra local $maildomain variable?  If you do so, then

 - You can lose the $maildomain variable local to this function;

 - "return what the user configured" does not have to be in the maildom=
ain
   sub;

 - the maildomain sub can return "localhost.localdomain" as a fallback
   default; and

 - various callsites of maildomain sub do not have to repeat the fallba=
ck
   default like your patch does.

> @@ -962,9 +1014,10 @@ X-Mailer: git-send-email $gitversion
>  		}
> =20
>  		if (!$smtp) {
> -			die "Unable to initialize SMTP properly. Check config. ",
> +			die "Unable to initialize SMTP properly. Check config and use --s=
mtp-debug. ",

This part is a good addition, but it needs to be in the earlier patch, =
no?
