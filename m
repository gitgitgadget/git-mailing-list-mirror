From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] stash: Add stash.showFlag config variable
Date: Thu, 27 Aug 2015 20:16:35 -0400
Message-ID: <CAPig+cQmTS5rRkfh1in9qR4MyP1_y9vNar7U4H3uayK6Vixa7w@mail.gmail.com>
References: <1440683528-11725-1-git-send-email-namhyung@gmail.com>
	<1440688825-1303-1-git-send-email-szeder@ira.uka.de>
	<CAM9d7chUf=srU060Q4+qQ4mFBaXmRL0yQ1Ns4UeWcDj62CFoYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Git List <git@vger.kernel.org>
To: Namhyung Kim <namhyung@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 28 02:16:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZV7LU-0000Dy-L2
	for gcvg-git-2@plane.gmane.org; Fri, 28 Aug 2015 02:16:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751842AbbH1AQg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Aug 2015 20:16:36 -0400
Received: from mail-yk0-f171.google.com ([209.85.160.171]:35557 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751449AbbH1AQf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Aug 2015 20:16:35 -0400
Received: by ykbi184 with SMTP id i184so38218776ykb.2
        for <git@vger.kernel.org>; Thu, 27 Aug 2015 17:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=Je2vUi6l1FR7l5/w7W5hKeu/J7n1h+H4R9KlPpPYLwY=;
        b=CUrFB0BqklMU9vcDrHxiYXkP2L+1VzAuj1mPncuq822fSLCvndDQyyPwKXGU5omfdZ
         DMVo4kjQwKT9/AsNrwLerMeQWx7bThZ+aUrqA6YwbnTzqZx8eqilbbVEvXi24qUBPpua
         wOMx+rw/fdybcKnmpEuIVUDPggRovzVoMBZmAmj1Z3IDGJlhytQk/H260T/tmZlMtL97
         IV6ofO3JvTfyrN2eqaq9vgZpBfQRseQ8hAG/nX6hnVGxciTK4orR2aAhEMqSIqEPVNS2
         LE2b1nFFosryaFw2BohFyBMWp+di0qxbrtYHEFmF7YEsI3COI50ziS/pQcBjWm/zGpVI
         SdgQ==
X-Received: by 10.170.114.200 with SMTP id g191mr5879013ykb.71.1440720995330;
 Thu, 27 Aug 2015 17:16:35 -0700 (PDT)
Received: by 10.37.208.78 with HTTP; Thu, 27 Aug 2015 17:16:35 -0700 (PDT)
In-Reply-To: <CAM9d7chUf=srU060Q4+qQ4mFBaXmRL0yQ1Ns4UeWcDj62CFoYg@mail.gmail.com>
X-Google-Sender-Auth: pwqpAaDT2w1ynn6pGh9s6xwAGOI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276689>

On Thu, Aug 27, 2015 at 11:36 AM, Namhyung Kim <namhyung@gmail.com> wro=
te:
> On Fri, Aug 28, 2015 at 12:20 AM, SZEDER G=C3=A1bor <szeder@ira.uka.d=
e> wrote:
>>  - This hunk runs the the exact same 'git config' command twice.  Ru=
n it
>>    only once, perhaps something like this:
>>
>>      show_flag=3D$(git config --get stash.showflag || echo --stat)
>>
>>    (I hope there are no obscure crazy 'echo' implemtations out there
>>    that might barf on the unknown option '--stat'...)
>
> What about `echo "--stat"` then?

Adding quotes around --stat won't buy you anything since the shell
will have removed the quotes by the time the argument is passed to
echo, so an "obscure crazy" 'echo' will still see --stat as an option.

POSIX states that printf should take no options, so:

    printf --stat

should be safe, but some implementations do process options (and will
complain about the unknown --stat option), therefore, best would be:

    printf '%s' --stat
