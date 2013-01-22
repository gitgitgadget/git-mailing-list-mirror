From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 03/10] t/t3511: add some tests of 'cherry-pick -s'
 functionality
Date: Tue, 22 Jan 2013 00:17:59 -0800
Message-ID: <20130122081758.GD6085@elie.Belkin>
References: <1358757627-16682-1-git-send-email-drafnel@gmail.com>
 <1358757627-16682-4-git-send-email-drafnel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, pclouds@gmail.com, git@vger.kernel.org,
	Brandon Casey <bcasey@nvidia.com>
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 22 09:18:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxZ3t-0008NZ-L7
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jan 2013 09:18:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752540Ab3AVISH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2013 03:18:07 -0500
Received: from mail-pa0-f51.google.com ([209.85.220.51]:41576 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752462Ab3AVISG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2013 03:18:06 -0500
Received: by mail-pa0-f51.google.com with SMTP id fb11so3928365pad.10
        for <git@vger.kernel.org>; Tue, 22 Jan 2013 00:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=Y3a3HuSn4XnaTugo5KX3uLLab0iWt+XwpxI6gQeggcs=;
        b=udpyPnkyKydxUpSl0tKP7PBfVlm7pZ6LBe7Jo8NMYWPQvVAo+NuerNCFUsg+SiPE6z
         wlCHRcVYjvICQc21WxfJyd6VJGYYJeiU8Ndmvt5rwM5Y3LmvubySVP6HE4aho/rmqjnc
         yrhY8O/BvEjvkVbttNfW695fhiPReQ6b5TevO+maSSVJZgtC8unij9joe94xBKulzzdv
         1JgOuXqcqkLfrAU0rxnOb8fLCeY8sEQyEPNyQ4wJpciHk8qGt6ayUm74GqkW7OsWZbLY
         pZRnzvU5fHBsLYfx9HAshuzYVpsEGFgOiJsZWopGWR/n5QjuIJrFhysWqVyfeJ9u4zt6
         4xAg==
X-Received: by 10.66.82.198 with SMTP id k6mr54072580pay.53.1358842685106;
        Tue, 22 Jan 2013 00:18:05 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id ir4sm10313367pbc.41.2013.01.22.00.18.01
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 22 Jan 2013 00:18:03 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1358757627-16682-4-git-send-email-drafnel@gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214214>

Brandon Casey wrote:

> --- /dev/null
> +++ b/t/t3511-cherry-pick-x.sh
> @@ -0,0 +1,111 @@
[...]
> +	test_commit "$mesg_one_line" foo b mesg-one-line &&
> +	git reset --hard initial &&
> +	test_commit "$mesg_no_footer" foo b mesg-no-footer &&
> +	git reset --hard initial &&
> +	test_commit "$mesg_broken_footer" foo b mesg-broken-footer &&
> +	git reset --hard initial &&
> +	test_commit "$mesg_with_footer" foo b mesg-with-footer &&
> +	git reset --hard initial &&
> +	test_commit "$mesg_with_footer_sob" foo b mesg-with-footer-sob &&

Neat.

[...]
> +test_expect_success 'cherry-pick -s inserts blank line after one line subject' '

In particular, a blank line after a one-line subject that starts with
the usual "subsystem:" convention is not mistaken for an RFC2822-style
header.  Good.

[...]
> +test_expect_failure 'cherry-pick -s inserts blank line after non-conforming footer' '

IIUC this is an illustration of false-positives from messages like
this one:

	base: do something great without a sign-off

	If he does that, it will be the best thing in the
	world: or so I think.

A worthy cause.  Could the example broken message be tweaked to
emphasize that use case?  With the current example, I'd consider
either result (blank line or no blank line) to be ok behavior by git.

[...]
> +test_expect_success 'cherry-pick -s inserts blank line when conforming footer not found' '

This is a simpler version of the previous test, without the distracting
colon.

[...]
> +test_expect_success 'cherry-pick -s adds sob when last sob doesnt match committer' '

Nice test for basic "-s" functionality.

[...]
> +test_expect_success 'cherry-pick -s refrains from adding duplicate trailing sob' '

And the other side of basic "-s" functionality.

One more test would be interesting: what does "-s" do when asked to
produce a duplicate signoff with an interspersed signoff by someone else?

	test: a patch with a more complicated life

	This patch bounced from $GIT_COMMITTER_NAME to Ms. Thor for
	tweaking, then back to $GIT_COMMITTER_NAME who will be
	recording it in permanent history.

	Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>"
	Signed-off-by: A U Thor <author@example.com>

With the changes suggested above or similar ones,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
