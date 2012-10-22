From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v5 1/3] completion: add new __gitcompadd helper
Date: Mon, 22 Oct 2012 02:41:21 +0200
Message-ID: <CAMP44s3guAhFe1ACrAzC9T05fCMAejU6Wn+GtYfSpmfJ8EX-xg@mail.gmail.com>
References: <1350229971-9343-1-git-send-email-felipe.contreras@gmail.com>
	<1350229971-9343-2-git-send-email-felipe.contreras@gmail.com>
	<20121017172808.GD2156@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Mon Oct 22 02:41:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQ65G-0005Of-Gf
	for gcvg-git-2@plane.gmane.org; Mon, 22 Oct 2012 02:41:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754789Ab2JVAlW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 21 Oct 2012 20:41:22 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:43365 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754746Ab2JVAlW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Oct 2012 20:41:22 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so1960520oag.19
        for <git@vger.kernel.org>; Sun, 21 Oct 2012 17:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=2AROctR68du5NSmqWyqU0rMKQtLq3/77JqeeKAjP2go=;
        b=UQNDf2cy3wzMhtw0zHNBnK+Wqpewlqrc2YrpojxoK8UEDrRRu0+r1KjbEb9QG5sKeX
         gTNiYVXw7cRo5e80ufbSeDhGMJpb35fZOXOyw7prhHy07kM2H68L4XwLWefsvKO/BK06
         SXH4dS3Pgp2anHd3K6WYOtT2rXFX03wAAe9jvuFNgsXAjnQ3PPHe/D+14F9GLx1ArZrx
         7YNGU/ZYdUsGBPXaavevQ86iErLVfMeEnOqfwqE+SZeb82oVOUVdW6kKcnCh11VHboHD
         2AqsnudVRNQB9KP1tKmlAG1ifGByPdQFQk1ecrVnR2Z+9KjjcSiHIdkXjEE2T1ahcOHV
         H5rA==
Received: by 10.60.32.19 with SMTP id e19mr7039248oei.9.1350866481155; Sun, 21
 Oct 2012 17:41:21 -0700 (PDT)
Received: by 10.60.4.74 with HTTP; Sun, 21 Oct 2012 17:41:21 -0700 (PDT)
In-Reply-To: <20121017172808.GD2156@goldbirke>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208166>

On Wed, Oct 17, 2012 at 7:28 PM, SZEDER G=C3=A1bor <szeder@ira.uka.de> =
wrote:
> On Sun, Oct 14, 2012 at 05:52:49PM +0200, Felipe Contreras wrote:

>> diff --git a/contrib/completion/git-completion.bash b/contrib/comple=
tion/git-completion.bash
>> index d743e56..01325de 100644
>> --- a/contrib/completion/git-completion.bash
>> +++ b/contrib/completion/git-completion.bash
>> @@ -225,6 +225,11 @@ _get_comp_words_by_ref ()
>>  fi
>>  fi
>>
>> +__gitcompadd ()
>> +{
>> +     COMPREPLY=3D($(compgen -W "$1" -P "$2" -S "$4" -- "$3"))
>> +}
>> +
>>  # Generates completion reply with compgen, appending a space to pos=
sible
>>  # completion words, if necessary.
>>  # It accepts 1 to 4 arguments:
>> @@ -238,13 +243,11 @@ __gitcomp ()
>>
>>       case "$cur_" in
>>       --*=3D)
>> -             COMPREPLY=3D()
>> +             __gitcompadd
>>               ;;
>>       *)
>>               local IFS=3D$'\n'
>> -             COMPREPLY=3D($(compgen -P "${2-}" \
>> -                     -W "$(__gitcomp_1 "${1-}" "${4-}")" \
>> -                     -- "$cur_"))
>> +             __gitcompadd "$(__gitcomp_1 "${1-}" "${4-}")" "${2-}" =
"$cur_" ""
>>               ;;
>>       esac
>>  }
>> @@ -261,7 +264,7 @@ __gitcomp ()
>>  __gitcomp_nl ()
>>  {
>>       local IFS=3D$'\n'
>> -     COMPREPLY=3D($(compgen -P "${2-}" -S "${4- }" -W "$1" -- "${3-=
$cur}"))
>> +     __gitcompadd "$1" "${2-}" "${3-$cur}" "${4- }"
>>  }
>
> I feel hesitant about this change.  One of the ways I'm exploring to
> fix the issues with shell metacharacters and expansion in compgen is
> to actually replace compgen.  We already iterate over all possible
> completion words in __gitcomp_1(), so it doesn't make much of a
> difference to do the filtering for the current word while we are at
> it.  However, the way __gitcompadd() encapsulates COMPREPLY=3D($(comp=
gen
> ...)), and tha basic idea of never touching COMPREPLY directly make
> this basically impossible.

How is it impossible? You can still replace compgen, all you have to
do is modify __gitcompadd and replace that code with whatever custom
code you want. You can change the arguments and everything. The only
limitation is that it should be the only place where COMPREPLY is
modified, and all is good. Well, it doesn't have to be only _one_
place, but the less functions that do this, the better.

>>  __git_heads ()
>> @@ -486,7 +489,7 @@ __git_complete_remote_or_refspec ()
>>                       case "$cmd" in
>>                       push) no_complete_refspec=3D1 ;;
>>                       fetch)
>> -                             COMPREPLY=3D()
>> +                             __gitcompadd
>>                               return
>>                               ;;
>>                       *) ;;
>> @@ -502,7 +505,7 @@ __git_complete_remote_or_refspec ()
>>               return
>>       fi
>>       if [ $no_complete_refspec =3D 1 ]; then
>> -             COMPREPLY=3D()
>> +             __gitcompadd
>>               return
>>       fi
>>       [ "$remote" =3D "." ] && remote=3D
>> @@ -776,7 +779,7 @@ _git_am ()
>>                       "
>>               return
>>       esac
>> -     COMPREPLY=3D()
>> +     __gitcompadd
>
> These changes effectively run compgen in a subshell to generate an
> empty completion reply.  While it doesn't really matter on Linux,
> it'll add another half a tenth of a second delay in those cases on my
> Windows machine.  At least it should be conditional, i.e. $(compgen
> ...) shouldn't be executed when there are no possible completion
> words.
>
> However, I think those COMPREPLY=3D() assignments are pointless anywa=
y.
> COMPREPLY is always empty when completion functions are invoked, so
> there is no need to explicitly set it to an empty array when we don't
> provide any words for completion.  Their only use is basically to
> explicitly tell us humans that in those cases we don't offer any word=
s
> for completion.  But we don't do that consistently: there are several
> places without offering words for completion and without COMPREPLY=3D=
(),
> e.g. the '__git_has_doubledash && return' pattern.
>
> Perhaps it would be time to get rid of these COMPREPLY=3D() assignmen=
ts?

I'm all for it, I never understood what was the purpose of that. I
believe zsh could benefit from this information to decide whether to
run the default completion (e.g. files) or not, but as you said, if
it's not used consistently for bash, there's no point in trying.

Cheers.

--=20
=46elipe Contreras
