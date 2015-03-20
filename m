From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/5] t5312: test object deletion code paths in a corrupted repository
Date: Thu, 19 Mar 2015 21:37:12 -0400
Message-ID: <CAPig+cQKhBw8air5y3NJaP5Rx9pXVaz9Lmvhe20AimW7pCsWBw@mail.gmail.com>
References: <20150317072750.GA22155@peff.net>
	<20150317072844.GA25191@peff.net>
	<CAPig+cTfqWr9un=4+QGs0jcUaV9U=z5Xyg3-r-D6dABGXUkmzg@mail.gmail.com>
	<20150320013217.GA15302@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 20 02:37:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYlsF-0005Ad-Sz
	for gcvg-git-2@plane.gmane.org; Fri, 20 Mar 2015 02:37:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750890AbbCTBhP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2015 21:37:15 -0400
Received: from mail-yh0-f45.google.com ([209.85.213.45]:34091 "EHLO
	mail-yh0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750731AbbCTBhN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2015 21:37:13 -0400
Received: by yhch68 with SMTP id h68so33521995yhc.1
        for <git@vger.kernel.org>; Thu, 19 Mar 2015 18:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=RSURBATaJ9z+1n6pXZQhgypyjD/qIzv5BTED2wnwm9A=;
        b=olh4LD6WCE4AncH+gVP9ymgPTs9YXInaCT5sq0Y59oiUMQUR8zOMxpNH6vcGVO8pPf
         0dQLacteKwcleJoxD/DjQtD8KcWDlPcssIKCGLMjeppE7uuWCTZ1TSz90+u41j1XxZQa
         YaBxtJGBFylpXG9qPkH1y1bDvNDT9JFNi734ha/ktlHW+OI/FG0jFOrToaavB10+yTEv
         n6J3sh7sfbsuJg7cIYw3AbWC8l/iSBKNlD1nVik50rhkvltqoSJ4C+Y+ETHNImlVNv7K
         iLxL5sCiYDr6L7W1UYY2hCeMuRexTEBHlTS/LpDt5G+5ZeDvrTyb8uJolsRSTX9Fbx2Y
         7jDg==
X-Received: by 10.170.188.10 with SMTP id f10mr92125020yke.22.1426815433032;
 Thu, 19 Mar 2015 18:37:13 -0700 (PDT)
Received: by 10.170.73.7 with HTTP; Thu, 19 Mar 2015 18:37:12 -0700 (PDT)
In-Reply-To: <20150320013217.GA15302@peff.net>
X-Google-Sender-Auth: Rlh576iykGh31ddlFBejVzsOoNI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265858>

On Thu, Mar 19, 2015 at 9:32 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Mar 19, 2015 at 09:16:52PM -0400, Eric Sunshine wrote:
>
>> > --- /dev/null
>> > +++ b/t/t5312-prune-corruption.sh
>> > @@ -0,0 +1,104 @@
>> > +# we do not want to count on running pack-refs to
>> > +# actually pack it, as it is perfectly reasonable to
>> > +# skip processing a broken ref
>> > +test_expect_success 'create packed-refs file with broken ref' '
>> > +       rm -f .git/refs/heads/master &&
>> > +       cat >.git/packed-refs <<-EOF
>>
>> Broken &&-chain.
>
> Thanks. I notice that a large number of broken &&-chains are on
> here-docs. I really wish you could put the && on the "EOF" line at the
> end of the here-doc. I understand _why_ that this not the case, but
> mentally it is where I want to type it, and I obviously sometimes fail
> to go back and fix it. I don't think there's a better solution in POSIX
> sh, though.

I wonder if test-lint could be enhanced to detect this sort of problem?
