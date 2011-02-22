From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: The future of gitweb (long term goals)
Date: Tue, 22 Feb 2011 18:02:09 +0100
Message-ID: <AANLkTin9dWXkaxqLdiosx-=jA9gbEqoJ8aAFoZMU94ih@mail.gmail.com>
References: <201102142039.59416.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, John Hawley <warthog9@kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 22 18:02:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PrvdY-0007Sy-Uj
	for gcvg-git-2@lo.gmane.org; Tue, 22 Feb 2011 18:02:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751183Ab1BVRCw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Feb 2011 12:02:52 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:63406 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750828Ab1BVRCv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Feb 2011 12:02:51 -0500
Received: by fxm17 with SMTP id 17so2956076fxm.19
        for <git@vger.kernel.org>; Tue, 22 Feb 2011 09:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=nxVUwKgDFABJepAs5oszHAQkTYHEt4y4l+RHycp0Pd8=;
        b=hXmN6khMtAMT592kOmbwd+bpvh/RFDPH/evFhdpFsjY857xXHDImpsexLfAZMHEsPo
         LkclvnobPUKLxWwUacwTHA4IflhLUk9UeiqbKMGl+055pRuAQS7pMzEQhHcQhLTGX2WR
         gkQIty2OUmVdBpdfgMK0hpTdrbRgo9Fb5O35s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=E76R10pHSddCxYAiDruFVPKWIuPFORPoY6jlyGt/CLSe891if8vpNnFoHlGxIy0FU9
         RGPQFzQub/T7aw6qwxZsYu8zzRMdC13pq32LxnkKqN50WQTjSkojKtreHhfYnOno6J6+
         hohpbY0Gy4oHSJn73xP1OQzfLt978c+tkxEG4=
Received: by 10.223.113.73 with SMTP id z9mr3692335fap.41.1298394129337; Tue,
 22 Feb 2011 09:02:09 -0800 (PST)
Received: by 10.223.2.201 with HTTP; Tue, 22 Feb 2011 09:02:09 -0800 (PST)
In-Reply-To: <201102142039.59416.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167565>

On Mon, Feb 14, 2011 at 20:39, Jakub Narebski <jnareb@gmail.com> wrote:
> This means that we are not able to use web (micro)framework, or use
> templating engine to create HTML instead of combination of CGI.pm
> methods and handcrafted HTML (worrying about proper escaping), or jus=
t
> use CGI::Cache or Plack::Middleware::Cache for adding output caching
> to gitweb. =C2=A0Though if one wants web interface in Perl that uses =
web
> framework (and is supposedly backwards-compatible with gitweb URLs),
> there is always Gitalist which uses Catalyst web framework.
>
> On the other hand requiring non-core Perl modules means that gitweb
> installation would be harder. =C2=A0We can work around this issue if =
there
> are a few small such modules (e.g. using Exception::Class or
> HTTP::Exception as base class for gitweb error handling) by putting
> them in 'inc/' and installing local version if they are not present,
> like Git.pm does with local Error.pm module. =C2=A0But for microframe=
work,
> or templating engine, or e.g. Plack (if we go the route to make gitwe=
b
> PSGI application) this would be rather out of question. =C2=A0Anyway,=
 in
> any case gitweb would probably require more complicated build system
> than current one... but moving to e.g. ExtUtils::MakeMaker shouldn't
> be that hard (see how Git.pm does it, only we can require Perl 5.8.3
> which has new enough EU::MM that supports DESTDIR).

Why do you think that if we use larger modules these things would get
harder?

There's already applications on the CPAN which can do "fat
packing". I.e. you could use Plack, Catalyst, Template and whatever
else but run some make target to pack gitweb and all its dependencies
into a single file.

Obviously it would be really big, and probably slow unless you ran it
as a fastcgi script. But that would be a tradeoff for making the
source easier to maintain.

But packing things like these is not a technical challange at all, and
probably way easier than reinventing the wheel each time you need some
small thing that's not in core, but is in a popular & well tested CPAN
module.
