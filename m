From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/3] t4150-am: refactor and clean common setup
Date: Thu, 28 May 2015 14:15:36 -0400
Message-ID: <CAPig+cRm6MRaR=Qgjxo2fGGcs522DstVedmq4j_fAQeBwG4ZUg@mail.gmail.com>
References: <1432675975-11020-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
	<CACRoPnQEJHPfoz0LjSs2X1CrW-TdVGb54XSrg6VWXP2tdyu5Uw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Git List <git@vger.kernel.org>,
	Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 28 20:15:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yy2LG-0002Ly-7z
	for gcvg-git-2@plane.gmane.org; Thu, 28 May 2015 20:15:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754032AbbE1SPi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2015 14:15:38 -0400
Received: from mail-ie0-f178.google.com ([209.85.223.178]:33953 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753704AbbE1SPh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2015 14:15:37 -0400
Received: by ieczm2 with SMTP id zm2so44955824iec.1
        for <git@vger.kernel.org>; Thu, 28 May 2015 11:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=vT+0dve/WpJZTs3NEw5ggswSIj8C1u9t3SXy1x7CkCA=;
        b=ZsRcTmay2f1oJlBE56VBqxdSwhT7odlOx3t2eBSSmRgeWWHSBDoRWpvVRBVopcqtsu
         JLNcks7D/MhDUhgeRVDnMWg4fNHz6g6tR36lq4DxyVPQCi3g146ZtknWKuAby0UjJIGx
         vXiaPeZ94e/YyAGu0KCBeNT86S+tr200KJOu70d6xmPmdo1OTVTNRMKvw+N3qCQAayiV
         kDggrcpBDhK/6h9SRbUELYP6l9NAppyA8gUiTmhiUijXUOQuDJTL5QOp0KWYmQ9VcQyn
         rTPO6ToiUbC6PzNEnFQKKgBoHuh8UwvT3Hzl0gX4/TKrfuq5ABK/zCSNiTKtDyIdNIk0
         JgJQ==
X-Received: by 10.43.135.5 with SMTP id ie5mr11086078icc.78.1432836936446;
 Thu, 28 May 2015 11:15:36 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Thu, 28 May 2015 11:15:36 -0700 (PDT)
In-Reply-To: <CACRoPnQEJHPfoz0LjSs2X1CrW-TdVGb54XSrg6VWXP2tdyu5Uw@mail.gmail.com>
X-Google-Sender-Auth: QZVVSV8Ja6_x9LyfIZ6bc03oLwQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270174>

On Thu, May 28, 2015 at 9:10 AM, Paul Tan <pyokagan@gmail.com> wrote:
> Take these comments/suggestions with a pinch of salt because I'm not
> that experienced with the code base as well ;-).

I agree with pretty much all of your review comments. See below for a
minor addenda.

> On Wed, May 27, 2015 at 5:32 AM, Remi Lespinet
> <remi.lespinet@ensimag.grenoble-inp.fr> wrote:
>> +setup_temporary_branch () {
>
> Maybe name this checkout_temp_branch() or something, since it more or
> less is just a wrapper around git-checkout.

checkout_temp_branch() doesn't give any indication that a new branch
is being created, so it may not be an improvement over
setup_temporary_branch(). A more apt name might be something like
new_temp_branch().

>> +       tmp_name=${2-"temporary"}
>
> I don't think the quotes are required. Also, I don't feel good about
> swapping the order of the arguments to git-checkout. (or making $2 an
> optional argument). As the patch stands, if I see
>
> setup_temporary_branch lorem
>
> I will think: so we are creating a temporary branch "lorem". But nope,
> we are creating a temporary branch "temporary" that branches from
> "lorem". I don't think writing setup_temporary_branch "temporary"
> "lorem" explicitly is that bad.

In fact, the second argument is never used in any of the three
patches, so it seems to be wasted functionality (at this time). If so,
then an even more appropriate name might be new_temp_branch_from().
Clearly, then:

    new_temp_branch_from lorem

creates a throw-away branch based upon 'lorem'.
