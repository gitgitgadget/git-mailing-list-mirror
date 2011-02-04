From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [1.8.0] Support quoting in .gitattributes, .gitignore
Date: Fri, 4 Feb 2011 20:17:01 +0700
Message-ID: <AANLkTi=0wrCVLetPsDGQAMYupfULFi6k2JijDnJQXPbO@mail.gmail.com>
References: <AANLkTikHNKmcapVWBAcufq8ONVWOWHbnL-H8Nf2WmKM5@mail.gmail.com> <7vbp2t0wld.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 04 14:17:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PlLXe-0001gh-Tq
	for gcvg-git-2@lo.gmane.org; Fri, 04 Feb 2011 14:17:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752709Ab1BDNRd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Feb 2011 08:17:33 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:57315 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752135Ab1BDNRc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Feb 2011 08:17:32 -0500
Received: by wyb28 with SMTP id 28so2233104wyb.19
        for <git@vger.kernel.org>; Fri, 04 Feb 2011 05:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=qlRsVXAk5HfHNnFj0bwgq1mLlU2aT3wQ/mLoGmRSd4w=;
        b=mr7S8JaoCs0JC8EYkB94kJJS8PjvWRYAva0zJurpW1utHcI+gQISbJECwHrWM3hqex
         34X8ydelGtbliaiDfeW8bjGJ794YF6RHacCiPCFWiHe83WkPuhQNYd1wYEvFuuQjVSZj
         ai4s/Sb1T0/QMV+6xyVf0yUwP8HdOotnUxaNI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=BGXTa+EIPlOx4UC21c2hvz3cjUE+EqGFVprHYLw3aFDdfCdiPWEgna+ySPeq5KtAmt
         uOCe7YQwB6F56ZN0TqPcP4NFS7FN9PlL2FhGhcLP/Wo4udSRFNsjzEjEmuectEtTFoME
         5F1fEK4/FzbE5VfrmKn4bigF8SZA0UJvrYIJg=
Received: by 10.216.50.72 with SMTP id y50mr660225web.28.1296825451567; Fri,
 04 Feb 2011 05:17:31 -0800 (PST)
Received: by 10.216.66.144 with HTTP; Fri, 4 Feb 2011 05:17:01 -0800 (PST)
In-Reply-To: <7vbp2t0wld.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166041>

On Fri, Feb 4, 2011 at 2:03 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>
>> Migration plan:
>>
>> I think a release note mentioning this is enough. No migration neede=
d.
>>
>> But to be safe, we can make post-1.7.5 warn users about patterns wit=
h
>> leading double quote. By 1.8.0, the new behavior will be used.
>
> That's obviously not a migration plan, and it is worse than not havin=
g the
> warning at all. =C2=A0People with paths that begin with dq (which I s=
uspect
> would be an empty set) will get wraning every time they do anything w=
ith
> git, and until 1.8.0 there is no way to turn that warnings off withou=
t
> breaking their pattern (like removing the entry from the attributes f=
ile),
> and when 1.8.0 comes their patterns will break.

Actually they can turn "<dq>abc" pattern to "[<dq>]abc". The tip
should be included in the warning. The warning would then be gone and
their patterns are 1.8.0-safe.

> How about introducing a new feature in .gitattributes file so that th=
e
> parser can tell if the file is (1) written pre-1.7.5 that depends on =
the
> old behaviour, (2) written post-1.7.5 by a person who is aware of the=
 dq
> convention, but still relying on the old behaviour, (3) written post-=
1.7.5
> to take advantage of the new behaviour? =C2=A0E.g., you can explicitl=
y mark
> your .gitattributes file by putting "# feature: no-cq-pattern" as the
> first line that the patterns in the file relies on the traditional
> behaviour, or "# feature: cq-pattern" to cause the parser to interpre=
t
> cquoted patterns, and the last 1.7.x will warn if a file does not hav=
e
> this explicit marking, but has a pattern that would change the behavi=
our.
> Then 1.8.0 would flip the default.

Nice. Chances of having a pattern with leading dq are small enough
that I'd rarely need to add "#feature: cq-pattern" in new
=2Egitattributes (i.e it does not bother the majority of users).

So the syntax of this line would be:

# feature: <feature>[,<feature>]*

where features in lowercase are mandatory, Git will abort if it does
not understand such a feature. Features start with an uppercase letter
is optional. Hmm?
--=20
Duy
