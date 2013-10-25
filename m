From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: git grep: search whole tree by default?
Date: Fri, 25 Oct 2013 11:52:18 +0700
Message-ID: <CACsJy8Cm7eShj22hve7=u2K5DKhv-t_KNUreRC+FZoehgfyEkg@mail.gmail.com>
References: <CAA01CsqgNKdDAc9OL9zdk=3tnK9GAG=6w+wP_XSoiefBOgfzRQ@mail.gmail.com>
 <vpqbo2guff7.fsf@anie.imag.fr> <xmqqmwlzrjdh.fsf@gitster.dls.corp.google.com>
 <87hac7hmrb.fsf@mcs.anl.gov> <xmqqob6fq0q1.fsf@gitster.dls.corp.google.com>
 <87zjpzg592.fsf@mcs.anl.gov> <vpqy55jogzr.fsf@anie.imag.fr>
 <20131024022736.GA24992@sigill.intra.peff.net> <xmqqd2muo3sz.fsf@gitster.dls.corp.google.com>
 <20131025043717.GC11810@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jed Brown <jed@59a2.org>,
	Piotr Krukowiecki <piotr.krukowiecki@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 25 06:52:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZZOJ-0008RU-T2
	for gcvg-git-2@plane.gmane.org; Fri, 25 Oct 2013 06:52:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751300Ab3JYEwt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Oct 2013 00:52:49 -0400
Received: from mail-qa0-f42.google.com ([209.85.216.42]:55559 "EHLO
	mail-qa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751237Ab3JYEwt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Oct 2013 00:52:49 -0400
Received: by mail-qa0-f42.google.com with SMTP id w8so315905qac.15
        for <git@vger.kernel.org>; Thu, 24 Oct 2013 21:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=yWDZU0gJKleTdnCcooxvHHKPPerMjpTyaW27gIay23Y=;
        b=h9gzjtZeS8yT2afuC/8SyEn5bcQPEt2oshcKtS056KOgz/Ad3Nt79cQMduI3/im1VP
         iutlYOB7ZbAOLrotBnSf70RJh/+36zt4jC7aD/9eKnE3wvaJC0mfbQneulY0WcdC0Lhz
         L4mnjBpP17XKY7VzB23Du8757ZoD0JK81yOcFhDL9Is7ZgiyAR2I9mok2hyPKvgz3bkN
         FD5b8Y0uRUEvFHHRpgpVpLMMxC2deyKPRlgJaJiwPhCHJrVjtCZecZ1vSs585+pEimQu
         A+D6sbCzk5Arh12dUK+eqJjlKNcauGI4222N27xB2KTOmOV4xu4m92ddOjl/wDGzIRQM
         Bj2g==
X-Received: by 10.224.79.12 with SMTP id n12mr7217394qak.109.1382676768702;
 Thu, 24 Oct 2013 21:52:48 -0700 (PDT)
Received: by 10.96.27.202 with HTTP; Thu, 24 Oct 2013 21:52:18 -0700 (PDT)
In-Reply-To: <20131025043717.GC11810@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236659>

On Fri, Oct 25, 2013 at 11:37 AM, Jeff King <peff@peff.net> wrote:
> On Thu, Oct 24, 2013 at 12:40:44PM -0700, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>>
>> > That would also provide people who do not like the change of default an
>> > escape hatch to keep the current behavior. And I do not think scripted
>> > use will be inconvenienced; they will already have to use "." or ":/" to
>> > be explicit (if they care) since the behavior is changing.
>>
>> There is a big difference between "scripted use will have an escape
>> hatch" and "scripted use will not be inconvenienced".
>
> I think my communication may have been muddled in transit. What I meant
> regarding inconvenienced was "not any more so than by simply changing
> the behavior in the first place, since scripts already will need to
> start becoming explicit due to the behavior change".
>
> And for the "escape hatch", I did not mean for scripts. I actually meant
> for users who do not like the extra typing and complain "stupid git, I
> always want '.'; you used to do what I want and now you do not".

Such an escape hatch may be better done as an alias than a config key
(an alias is a config key anyway). I know it won't be easy to "add '.'
if no pathspecs are given", using shell script. But that's something
we could improve, hopefully. An option is we could just export
PATHSPEC_PREFER_* flags via a command line (like --literal-pathspecs).
-- 
Duy
