From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] revision: Show friendlier message.
Date: Mon, 25 Jun 2012 16:07:48 -0700
Message-ID: <7vsjdjdm7v.fsf@alter.siamese.dyndns.org>
References: <1340478681-58476-1-git-send-email-muhtasib@gmail.com>
 <7vobo8hsee.fsf@alter.siamese.dyndns.org>
 <CAA3EhHJbKj+nbVsZtijsH+h7sFcyeBwT9K=BTeqAuMzSH0RGmg@mail.gmail.com>
 <7vr4t3f9y6.fsf@alter.siamese.dyndns.org>
 <CAA3EhHLy+5Vfw0T=7VEBi+2ZxjS4x2dndox+M_E06v3FtoNQXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Leila <muhtasib@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 26 01:07:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjINw-0000PJ-PD
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jun 2012 01:07:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757125Ab2FYXHv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Jun 2012 19:07:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50007 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757080Ab2FYXHu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Jun 2012 19:07:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2FE7F9FAE;
	Mon, 25 Jun 2012 19:07:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=3aQVUlCaM/Hq
	WgqRQNWBjwqUtus=; b=u/NvfQPNH6czqG8xv4e0QV/indS/QT6Jw8TYOV7SJMXM
	wY2OjNZQ/EfwHJ2J0/Ccbbc9Uv+YmCNkhP9ZEzhraz3GQ6jmAbwCUvjBw4Kdf2Jd
	ZoJtFjoVNQBZ2l+KC1b6XhW5+Jngo9xG/1a1WLg9VbMdDIH6rOkkTOxOLT+w9bg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=AXPxZX
	eY7/ULc2EMhpFWDSthOLNtCNLQslDSi1PoJe7ursbTLSTc/x7plyieUn4xvWQeF6
	LiZ+anLGhWlyp+t5aa7T/o4ykX8iLeT5FWKlO3ND477PJ8RInCMGenQ7pjWvN3Wz
	il/pF3+jGj4BIQq6xyl5jbrjsPJa+ETu7KEW8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 270479FAD;
	Mon, 25 Jun 2012 19:07:50 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A13579FAC; Mon, 25 Jun 2012
 19:07:49 -0400 (EDT)
In-Reply-To: <CAA3EhHLy+5Vfw0T=7VEBi+2ZxjS4x2dndox+M_E06v3FtoNQXg@mail.gmail.com> (Leila's
 message of "Mon, 25 Jun 2012 18:53:57 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 95899E12-BF1A-11E1-8C6A-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200605>

Leila <muhtasib@gmail.com> writes:

>> The "bad HEAD and no revs..." part, if we choose not to even error
>> on this, can be removed.
>
> Yea, I think we should return successfully, and warning() does that.
> But if we choose to display a message, I don't think it should be a
> warning (esp for the empty repo case). It should look like the sample
> printf below, but the v2 of the patch I submitted doesn't include the
> message.

I said "*if* we choose not to" for a reason.  It can be argued that
it technically is a regression that "git log" does *not* error out
for an unborn history, as that is different from the way the command
has behaved forever.

> + if (!opt.def && !rev.cmdline.nr) {
> +          printf("No commit(s) to display.\n");
> +          return 0;
> +        }
>
>>
>> Also other cmd_frotz() functions in the same file might want to use
>> the s/"HEAD"/default_to_head_if_exists()/ conversion.
>
> Ok, I've updated other functions in the same file.

Again, "might want" was a key phrase.  I didn't look at each and
every one of them and thought if it made sense to change their
behaviour.

> Regarding this implementation:
>
>> +static const char *default_to_head_if_exists(void)
>> +{
>> + =C2=A0 =C2=A0 =C2=A0 unsigned char sha1[20];
>> + =C2=A0 =C2=A0 =C2=A0 if (resolve_ref_unsafe("HEAD", sha1, 1, NULL)=
)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return "HEAD";
>> + =C2=A0 =C2=A0 =C2=A0 else
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;
>> +}
>> +
>
> I initially wrote something with this logic, do you have a preference=
?
>
> +static const char *default_to_head_if_exists(void)
> +{
> +       struct commit *commit =3D lookup_commit_reference_by_name("HE=
AD");
> +       if(commit)
> +               return "HEAD";
> +       else
> +               return NULL;
> +}

The reason why I used resolve_ref_unsafe() is because it will only
grab HEAD and not refs/heads/HEAD or any confusing mess, even in a
sick repository.
