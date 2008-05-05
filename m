From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [PATCH v2 4/5] Make boundary characters for --color-words configurable
Date: Mon, 5 May 2008 09:40:47 +0800
Message-ID: <46dff0320805041840g1b9362d3u138b9d40cde160f2@mail.gmail.com>
References: <46dff0320805020726y2592732cj9aef0111e5b2288a@mail.gmail.com>
	 <1209815828-6548-2-git-send-email-pkufranky@gmail.com>
	 <1209815828-6548-3-git-send-email-pkufranky@gmail.com>
	 <1209815828-6548-4-git-send-email-pkufranky@gmail.com>
	 <1209815828-6548-5-git-send-email-pkufranky@gmail.com>
	 <7vy76rtfns.fsf@gitster.siamese.dyndns.org>
	 <46dff0320805031732x25286707r991358162046c07c@mail.gmail.com>
	 <alpine.DEB.1.00.0805041040560.30431@racer>
	 <46dff0320805040935n22354e1bta85b3f3fe7c16cad@mail.gmail.com>
	 <7v63ttq0y8.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Junio C Hamano" <junio@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 05 03:41:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jspi0-0007yK-ED
	for gcvg-git-2@gmane.org; Mon, 05 May 2008 03:41:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753537AbYEEBkw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 May 2008 21:40:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753424AbYEEBkv
	(ORCPT <rfc822;git-outgoing>); Sun, 4 May 2008 21:40:51 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:11857 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753419AbYEEBku (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 May 2008 21:40:50 -0400
Received: by yw-out-2324.google.com with SMTP id 9so349960ywe.1
        for <git@vger.kernel.org>; Sun, 04 May 2008 18:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=lvkRUY59dCNeG1ee2b86c6hiMs/q9KoyMi5HPnVw7PU=;
        b=dvJ0QU2YunG13GqOslQdzFMyNx9L2s/CCyDm1rhwqd3MtSP8fXw3khxlGEyk2IiGT1RSHO0PSG457+fgdnw00uMINEeY39ekl9lik5zgm++8VqRp+0kpNjs58TMhlK2on99Xjq/PjWTgrmZmnMeSHEmiv8nbHKV0ss800uA4kfk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fyTy5nlurfYD14sjJMp1vrvy2Jf29+vPe+1JH5I+HBxRnV7fjXn1IwtVJe6b5+/Jwkd6HAQa/Yjs4TOlPJXr/5JHGrmNSKCWjWp5ypaSrgEg3PtM1z3+VZlN8cgnVuSM/uV+pAe8DO6tz7xdoHc5XH65mF4zD/2rU1n9OxWn92g=
Received: by 10.150.83.22 with SMTP id g22mr5573669ybb.146.1209951647701;
        Sun, 04 May 2008 18:40:47 -0700 (PDT)
Received: by 10.151.114.1 with HTTP; Sun, 4 May 2008 18:40:47 -0700 (PDT)
In-Reply-To: <7v63ttq0y8.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81215>

On 5/5/08, Junio C Hamano <junio@pobox.com> wrote:
>
> So the overall algorithm I think should be is:
>
>  - make the input into stream of tokens, where a token is either a run of
>   word characters only, non-word punct characters only, or whitespaces
>   only;
>
>  - compute the diff over the stream of tokens;
>
>  - emit common tokens in white, deleted in red and added in green.
>
> Notice that you do not have to special case LF in any way if you go this
> route.
>
> You could do this with only two classes, and use a different tokenization
> rule: a token is either a run of word characters only, or each byte of non
> word character becomes individual token.  This however would yield a
> suboptimal result:
>
>    -if (i > 1)
>    +while (i >= 0)
>
>    preimage       postimage        word-diff
>    6966                            -6966       if
>                   7768696c65       +7768696c65 while
>    20             20                20         ' '
>    28             28                28         (
>    69             69                69         i
>    20             20                20         ' '
>    3e             3e                3e         >
>                   3d               +3d         =
>    20             20                20         ' '
>    31                              -31         1
>                   30               +30         0
>    29             29                29         )
>
> This would give "/if/while/ (i >//=/ /1/0/)".  A logical unit ">=" is
> chomped into two tokens, which is suboptimal for the same reason why the
> output "H/ello/i,/" from the original char-diff based one was suboptimal.
>

For this example,both "/if/while/ (i />/>=/ /1/0/)" and  "/if/while/
(i >//=/ /1/0/)" are fine to me. However, the run of non-word
characters shouldn't always be considered as a single token.

For example

  - **************
  + ************

If  just a '+' is removed, surely "************/*//" is better.

And when designing, i think it's better to take multi-byte characters
into account. For multi-byte characters (especially CJK), every
character should be considered as a token. if we consider either a run
of word characters or a run of non-word characters as a single token,
there is no way to specify every character as a token.

So from this viewpoint, is it better to use single-token character or
something else instead of non-word character?

Another consideration: Space information is also important for me when
using --color-words. However, i can't distinguish between the removed
spaces and added spaces in current implementaion. So how about use
red/green background color for removed/added spaces?

-- 
Ping Yin
