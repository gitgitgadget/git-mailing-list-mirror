From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RTC/PATCH] Add 'update-branch' hook
Date: Mon, 21 Apr 2014 16:35:36 -0500
Message-ID: <53558f285f379_640076f2f094@nysa.notmuch>
References: <1398047016-21643-1-git-send-email-felipe.contreras@gmail.com>
 <53558AD0.3010602@gmail.com>
 <53558a663ea74_604be1f30c2c@nysa.notmuch>
 <53558F6F.7080306@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
To: Ilya Bobyr <ilya.bobyr@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 21 23:46:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcM2O-0005DD-2K
	for gcvg-git-2@plane.gmane.org; Mon, 21 Apr 2014 23:46:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754599AbaDUVqA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Apr 2014 17:46:00 -0400
Received: from mail-yk0-f182.google.com ([209.85.160.182]:37583 "EHLO
	mail-yk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754434AbaDUVp6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Apr 2014 17:45:58 -0400
Received: by mail-yk0-f182.google.com with SMTP id 142so3864004ykq.41
        for <git@vger.kernel.org>; Mon, 21 Apr 2014 14:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-type:content-transfer-encoding;
        bh=azvxFBU01IXv1NHNTV3+rzUXtT2cFsbsQ0LcLOtLYKU=;
        b=ix4FtDsoVHTWg8HV7N2P/l88viYY6hngCm/cLKao5m+smpJet3rOwp9L5B8DRIUQsx
         fK1HFz/0syrjijnhe7gbvCQQ3/es14OeyyyzltUchxGwXlvyuUFT7VXXHQBC0Lld2iVG
         dAugqwvW4X4xhCCpbyA+Zo6mUZ7Fr5ETbp3XBECHRRppbqgjX3K8gvdfRelJlu6+18qK
         dSfT31/JXP0WlzGrnZrXSTqYuMmci4xX3jn7rHMN56QtCI0sNwA08Lddcnb5RZ0ZJ5nd
         lkSn9nu7jWQNgULuEYZW2bWVB42uDMMQfjPxYq2qPAyj53y2DvB/jYxBfOxHLdbuxDee
         WRxg==
X-Received: by 10.236.112.39 with SMTP id x27mr6062263yhg.103.1398116758394;
        Mon, 21 Apr 2014 14:45:58 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id c25sm65296897yhn.3.2014.04.21.14.45.56
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Apr 2014 14:45:57 -0700 (PDT)
In-Reply-To: <53558F6F.7080306@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246652>

Ilya Bobyr wrote:
> On 4/21/2014 2:15 PM, Felipe Contreras wrote:
> > Ilya Bobyr wrote:
> >> On 4/20/2014 7:23 PM, Felipe Contreras wrote:
> >>> [...]
> >>>
> >>> diff --git a/t/t5408-update-branch-hook.sh b/t/t5408-update-branch-hook.sh
> >>> new file mode 100755
> >>> index 0000000..d921c0e
> >>> --- /dev/null
> >>> +++ b/t/t5408-update-branch-hook.sh
> >>> @@ -0,0 +1,39 @@
> >>> +#!/bin/sh
> >>> +
> >>> +test_description='Test the update-branch hook'
> >>> +
> >>> +. ./test-lib.sh
> >>> +
> >>> +setup () {
> >>> +	mkdir -p .git/hooks &&
> >>> +	cat > .git/hooks/update-branch <<-'EOF' &&
> >>> +	#!/bin/sh
> >>> +	echo $@ > .git/update-branch.args
> >>> +	EOF
> >>> +	chmod +x .git/hooks/update-branch &&
> >>> +	echo one > content &&
> >>> +	git add content &&
> >>> +	git commit -a -m one
> >>> +}
> >>> +
> >>> +setup
> >> According to t/README `setup` should be inside an assertion just as any
> >> other test:
> > I have a bunch of 'setup' calls outside such assertions already in other test
> > scripts. If you know how to put single quotes inside of single quotes in a
> > shell script, please share that knowledge, otherwise the setup must be outside.
> >
> > Of course we could do the extremely reduntant:
> >
> > test_expect_success 'setup' '
> >   setup
> > '
> 
> Setup does not look any different from the other tests.
> If you need single quotes you could use double quotes outside.  Though,
> you would have to quote other things as well.
> t0000-basic.sh has a lot of tests that do that.
> Like this, for example:
> 
> test_expect_success 'setup' "
> 	mkdir -p .git/hooks &&
> 	cat > .git/hooks/update-branch <<-\\EOF &&
> 	#!/bin/sh
> 	echo \$@ > .git/update-branch.args
> 	EOF
> 	chmod +x .git/hooks/update-branch &&
> 	echo one > content &&
> 	git add content &&
> 	git commit -a -m one
> "

That is not maintainable at all.

-- 
Felipe Contreras
