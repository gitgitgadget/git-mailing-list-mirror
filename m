From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v2 2/6] cherry-pick: treat CHERRY_PICK_HEAD and
 REVERT_HEAD as refs
Date: Thu, 25 Jun 2015 18:29:25 -0400
Organization: Twitter
Message-ID: <1435271365.7900.16.camel@twopensource.com>
References: <1435265110-6414-1-git-send-email-dturner@twopensource.com>
	 <1435265110-6414-2-git-send-email-dturner@twopensource.com>
	 <xmqqsi9fwl0i.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 26 00:29:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8FeI-0001at-3O
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jun 2015 00:29:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751495AbbFYW3a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2015 18:29:30 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:36491 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750993AbbFYW32 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2015 18:29:28 -0400
Received: by igbiq7 with SMTP id iq7so2045147igb.1
        for <git@vger.kernel.org>; Thu, 25 Jun 2015 15:29:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=fdZHzH5ul844QLue8An2w0xJZLyqXIJXyfi92Z3EBeE=;
        b=KywFKLMlDg9FJ0Pf5hiidp/cFMKClviNj6H6GIojD4RkkiGuBX8nlAh29fCNu5zvO9
         vexX88Ig3EadruIOrqrbK0FfkeKElnEPbaCYngs4YPX33BM8Btu4bZtZanTUlaSzxyTG
         ECUyqArbvdaqdgDuMHYRRIH0mFz4/TktOiWAYy2TGEGv6OiCLuVicyx/EN7E9S0aTGpa
         j6i1eORGDztYwVW65jMN3e+frA/WzrCLXEdZwJiWFIml1IbP0Y0tOu4YL95GJ6RnNXew
         MaccLKF/wdBVYmODM43FsyE59eb1bC6p5pSACkLDo3jXZvYzeMLJ0DqV84Bm59h7ysY9
         QhAA==
X-Gm-Message-State: ALoCoQlaITKcx3bYSOJ5W/CYYDTDxQt/4j8Ki85vcABnfbbGe8ZgKbM/DZkIr1ETPpXucgEdRl1u
X-Received: by 10.50.102.68 with SMTP id fm4mr7225249igb.25.1435271367963;
        Thu, 25 Jun 2015 15:29:27 -0700 (PDT)
Received: from ubuntu (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by mx.google.com with ESMTPSA id d4sm20489365iod.17.2015.06.25.15.29.26
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jun 2015 15:29:26 -0700 (PDT)
In-Reply-To: <xmqqsi9fwl0i.fsf@gitster.dls.corp.google.com>
X-Mailer: Evolution 3.12.10-0ubuntu1~14.10.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272742>

On Thu, 2015-06-25 at 14:11 -0700, Junio C Hamano wrote:
> David Turner <dturner@twopensource.com> writes:
> 
> > Instead of directly writing to and reading from files in
> > $GIT_DIR, use ref API to interact with CHERRY_PICK_HEAD
> > and REVERT_HEAD.
> >
> > Signed-off-by: David Turner <dturner@twopensource.com>
> > ---
> 
> I may have said this already in the last round, but I cannot shake
> off the feeling that this patch is doing two completely unrelated
> things at once.
> 
> The change to refs.c that introduced the should_autocreate_reflog()
> helper (which is a good idea even without any other changes in this
> patch) 

I'll break that out into a separate patch when I reroll.

> and then using that to commit_ref_update() does not have
> anything to do with CHERRY_PICK_HEAD/REVERT_HEAD, does it?

I had thought that it did, but some testing shows that it does not (or
at least does not yet).  The original series of patches was assembled
out of a long process of making the test suite pass with the alternate
ref backend.  I expect that as I rewrite that series, I'll either figure
out what issues these change solved, or remove them.  In this case, I'll
split the patch.

>  * commit_ref_update() gained a new "flags" parameter, but it does
>    not seem to be used at all.  Why?

cruft, will remove.
