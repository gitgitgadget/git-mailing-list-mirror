From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH/FYI v4 13/12] fixup! t/t3511: add some tests of
 'cherry-pick -s' functionality
Date: Tue, 12 Feb 2013 11:56:20 -0800
Message-ID: <20130212195620.GB12240@google.com>
References: <1360664260-11803-1-git-send-email-drafnel@gmail.com>
 <1360664260-11803-14-git-send-email-drafnel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, pclouds@gmail.com
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 12 20:56:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5LyD-00013w-Qo
	for gcvg-git-2@plane.gmane.org; Tue, 12 Feb 2013 20:56:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933637Ab3BLT40 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2013 14:56:26 -0500
Received: from mail-pa0-f43.google.com ([209.85.220.43]:45993 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933530Ab3BLT4Z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2013 14:56:25 -0500
Received: by mail-pa0-f43.google.com with SMTP id bh2so280791pad.30
        for <git@vger.kernel.org>; Tue, 12 Feb 2013 11:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=tb8Y/rmHC6ZbuY0ySKO5av+MOOIm2Mn0P7gQGp+v3Uc=;
        b=TSWfYWEzyf/1iC4WGTheLBOMvAKt1s92gBIxrIOMgTK8sEemRLM9RWEPlDhMedhLip
         TJOykaXqHDpjUBKO9gl1qHEz/pxZIUrvU1QIwlZuB7oo2rZbDPD6YCRmyEYAWUhZIdNK
         ayP13CEFHXCMom7yBg9/JiP0Ua5hDCfRmL+G/0akAxqX0JQtsktBEUJv8QOn330AQhc3
         SIxQtCKiAx+tBw8F74OZLla+Hya+25X4jKhk1oEdlnzYG4ZBB0vY8lnqqTlmw3of+LRP
         YIE1VsSEVSvpKRJ07z4J+hbbp9SRpJ39Nr7tcQSGqCFXkwHidSKXBTKsyghkZjmN4o09
         uQlQ==
X-Received: by 10.66.222.35 with SMTP id qj3mr35750637pac.69.1360698984889;
        Tue, 12 Feb 2013 11:56:24 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id m3sm77351646pav.4.2013.02.12.11.56.22
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 12 Feb 2013 11:56:23 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1360664260-11803-14-git-send-email-drafnel@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216181>

Brandon Casey wrote:

> I'm not sure we should apply this though.  I'm leaning towards saying that
> the 'cherry-pick -s' behavior with respect to a commit with an empty message
> body should be undefined.  If we want it to be undefined then we probably
> shouldn't introduce a test which would have the effect of defining it.

Maybe it would make sense to just check that cherry-pick doesn't
segfault in this case?

That is, compute the output but don't compare it to expected output, as
in:

	test_expect_success 'adding signoff to empty message does something sane' '
		git reset --hard HEAD^ &&
		git cherry-pick --allow-empty-message -s empty-branch &&
		git show --pretty=format:%B -s empty-branch >actual &&

		# sign-off is included *somewhere*
		grep "^Signed-off-by:.*>\$" actual
	'

Alternatively, if there are only a few sane behaviors, a test can check
for all of them and pass as long as git follows one.  I haven't thought
carefully enough about this example to suggest doing that.

Thanks,
Jonathan
