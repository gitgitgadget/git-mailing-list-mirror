From: Nathan Bullock <nathanbullock@gmail.com>
Subject: Re: Autocompletion - commands no longer work as stand alone
Date: Fri, 20 Jan 2012 14:33:03 -0500
Message-ID: <CAPx=VfrZ+TZhX51gUfyep2Az0zwmdM3YsEkLMzxa7LSEUFzOnw@mail.gmail.com>
References: <CAPx=Vfp_HVr5W1fFic_1k+JsKr2RAKd-RK=VkfSgo7qkb5GsAw@mail.gmail.com>
	<CAPx=Vfqj3UZuFv3Xmupy7k9arUxyZJyprm628p9QVKabdOz8cw@mail.gmail.com>
	<7vwr8mdvo8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 20 20:33:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RoKD0-0006Bg-P2
	for gcvg-git-2@lo.gmane.org; Fri, 20 Jan 2012 20:33:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754681Ab2ATTdH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Jan 2012 14:33:07 -0500
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:44200 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753659Ab2ATTdD convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jan 2012 14:33:03 -0500
Received: by obcva7 with SMTP id va7so1089792obc.19
        for <git@vger.kernel.org>; Fri, 20 Jan 2012 11:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=w6baHczs0imf8VWD2JOFnkUYO8OfeXaxNiA2YLxT6PU=;
        b=IDGRYpdFlirIpb/rTHhGYN3y2D4MCixzWPivuwmNta/DRWrX73FBd6axJCf7AanrLN
         NVGktMULvJAgeFst4mp0uTkDXrxyXT7hfWmY5wYuDbMaPeC8ZTVqrYans+3sZ9VO7hvK
         B8fJw6sUXVwyCyKLCzfe0yJfW3C12yzCaVwLs=
Received: by 10.182.59.41 with SMTP id w9mr27918251obq.70.1327087983253; Fri,
 20 Jan 2012 11:33:03 -0800 (PST)
Received: by 10.60.43.170 with HTTP; Fri, 20 Jan 2012 11:33:03 -0800 (PST)
In-Reply-To: <7vwr8mdvo8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188895>

So just as a comment on the use of underscores. The actual main auto
complete function, _git, also starts with an underscore. From looking
at the code it looked like the double underscore functions were the
internal ones.


2012/1/20 Junio C Hamano <gitster@pobox.com>:
> Pinging Szeder. I personally do not think it is a crime for us to bre=
ak
> anything that uses an internal function whose name begins with unders=
core,
> but people more deeply involved in this part of the system may have i=
deas
> to help supporting even such users.
>
> Nathan Bullock <nathanbullock@gmail.com> writes:
>
>> I have for a number of years had the following in my .bashrc
>>
>> alias br=3D"git branch"
>> complete -F _git_branch br
>>
>> As well as similar commands for co and log.
>>
>> Recently though this broke, now when I type something like "br
>> mas<command completion>" it will occasionally complain with messages
>> like:
>> bash: [: 1: unary operator expected
>>
>> From digging through the source it looks like this was broken back i=
n
>> April. (The commit is show at the bottom of this email.)
>>
>> So my questions are:
>> 1. Is it reasonable for things like _git_branch to work as a
>> standalone autocompletion function instead of having to go through
>> _git? I certainly like it to work as a standalone function. I also u=
se
>> it to add autocompletion to other bash scripts that I use frequently=
=2E
>>
>> 2. If I add code that verifies that the variable cword exists at the
>> start of these functions and only if not call something like
>> _get_comp_words_by_ref -n =3D: cur words cword prev. Would that be
>> reasonable? I think this should address the performance concerns tha=
t
>> caused these to be removed in the first place, but it may make the
>> code uglier.
>>
>> I have already added wrapper functions in my bashrc so that this is =
no
>> longer a problem for me, but there may be other people who start
>> hitting this as well once they start using newer versions of git.
>>
>> Nathan
>>
>>
>> commit da4902a73017ad82b9926d03101ec69a2802d1e7
>> Author: SZEDER G=E1bor <szeder@ira.uka.de>
>> Date: =A0 Thu Apr 28 18:01:52 2011 +0200
>>
>> =A0 =A0completion: remove unnecessary _get_comp_words_by_ref() invoc=
ations
>>
>> =A0 =A0In v1.7.4-rc0~11^2~2 (bash: get --pretty=3Dm<tab> completion =
to work
>> =A0 =A0with bash v4, 2010-12-02) we started to use _get_comp_words_b=
y_ref()
>> =A0 =A0to access completion-related variables. =A0That was large cha=
nge, and to
>> =A0 =A0make it easily reviewable, we invoked _get_comp_words_by_ref(=
) in each
>> =A0 =A0completion function and systematically replaced every occuran=
ce of
>> =A0 =A0bash's completion-related variables ($COMP_WORDS and $COMP_CW=
ORD) with
>> =A0 =A0variables set by _get_comp_words_by_ref().
>>
>> =A0 =A0This has the downside that _get_comp_words_by_ref() is invoke=
d several
>> =A0 =A0times during a single completion. =A0The worst offender is pe=
rhaps 'git
>> =A0 =A0log mas<TAB>': during the completion of 'master'
>> =A0 =A0_get_comp_words_by_ref() is invoked no less than six times.
>>
>> =A0 =A0However, the variables $prev, $cword, and $words provided by
>> =A0 =A0_get_comp_words_by_ref() are not modified in any of the compl=
etion
>> =A0 =A0functions, and the previous commit ensures that the $cur vari=
able is
>> =A0 =A0not modified as well. =A0This makes it possible to invoke
>> =A0 =A0_get_comp_words_by_ref() to get those variables only once in =
our
>> =A0 =A0toplevel completion functions _git() and _gitk(), and all oth=
er
>> =A0 =A0completion functions will inherit them.
>>
>> =A0 =A0Signed-off-by: SZEDER G=E1bor <szeder@ira.uka.de>
>> =A0 =A0Signed-off-by: Junio C Hamano <gitster@pobox.com>
