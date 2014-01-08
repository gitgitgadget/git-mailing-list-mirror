From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] merge: make merge state available to prepare-commit-msg
 hook
Date: Wed, 8 Jan 2014 14:01:19 -0800
Message-ID: <20140108220119.GN3881@google.com>
References: <6B177FFA-1797-45FE-9EF1-2C9E6EE8A234@yaauie.com>
 <DA9E6645-82DC-4714-845F-423726F96A40@yaauie.com>
 <vpqr48ip7bm.fsf@anie.imag.fr>
 <B19C65C1-C2D9-486F-AEA7-1497A3B5C5B4@yaauie.com>
 <vpqtxdenoug.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ryan Biesemeyer <ryan@yaauie.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Jeff King <peff@peff.net>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jan 08 23:01:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W11C6-0000nt-0l
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jan 2014 23:01:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932148AbaAHWBn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jan 2014 17:01:43 -0500
Received: from mail-qa0-f52.google.com ([209.85.216.52]:44149 "EHLO
	mail-qa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932133AbaAHWBl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jan 2014 17:01:41 -0500
Received: by mail-qa0-f52.google.com with SMTP id j15so1738562qaq.39
        for <git@vger.kernel.org>; Wed, 08 Jan 2014 14:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=W5SvW8WOOcAd+H+yPdNTVW/ANpOUj22QYOUzH3ftt9s=;
        b=xM1b4xCtayZyjrKWoe83vQgDAu3a107kUXvpDfXQbDkzRNGITbJsbkYx41JX9faVOv
         Lg48Wdmd179kS3fQbRm2WM5OtLGmzqFZ11GC/CF0Ma/LDgajT3DkOiGCto///olX3xtt
         v88/ecqAMW6s5RoJe8kSN0Q7K9nucdqaJzPUh6xv1dVNgE47VDBCmUxG9X1J6YCb9s3Z
         9SEH25gKFHYup60oMpRXwFyo30+yx7aWW0Av7QkXbR6afYqdI7e6ucmrP4LJSVNsm5VB
         MduHtu4xzfiQ0IwVfcWoZ2luCzydrQDffbnCJOiNuV5you3lqyIdZjg+dEyWos2cvR2K
         pefw==
X-Received: by 10.49.39.165 with SMTP id q5mr217310031qek.48.1389218500956;
        Wed, 08 Jan 2014 14:01:40 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id 8sm3144685qas.17.2014.01.08.14.01.31
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 08 Jan 2014 14:01:40 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <vpqtxdenoug.fsf@anie.imag.fr>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240228>

Matthieu Moy wrote:

> Jonathan's answer is an option. Another one is
[...]
> So if the cleanup goes wrong, one can notice.

test_when_finished also makes the test fail if the cleanup failed.

Another common strategy is

	test_expect_success 'my exciting test' '
		# this test will rely on these files being absent
		rm -f a b c etc &&

		... rest of the test goes here ...
	'

which can be a handy way for an especially picky test to protect
itself (for example with 'git clean -fdx') regardless of the state
other test assertions create for it.

This particular example (merge --abort) seems like a good use for
test_when_finished because it is about a specific test having made a
mess and needing to clean up after itself to restore sanity.

Hoping that clarifies,
Jonathan
