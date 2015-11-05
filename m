From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v6 25/25] refs: break out ref conflict checks
Date: Thu, 05 Nov 2015 11:22:15 -0500
Organization: Twitter
Message-ID: <1446740535.4131.50.camel@twopensource.com>
References: <cover.1446534991.git.mhagger@alum.mit.edu>
		 <3060e6410e8798064ef84cd31645021d1b84fbb9.1446534991.git.mhagger@alum.mit.edu>
	 <1446670884.4131.42.camel@twopensource.com> <563AD452.2030301@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Nov 05 17:22:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZuNIt-0001XN-JL
	for gcvg-git-2@plane.gmane.org; Thu, 05 Nov 2015 17:22:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161981AbbKEQWT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Nov 2015 11:22:19 -0500
Received: from mail-qk0-f171.google.com ([209.85.220.171]:36675 "EHLO
	mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756303AbbKEQWR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Nov 2015 11:22:17 -0500
Received: by qkcl124 with SMTP id l124so34512428qkc.3
        for <git@vger.kernel.org>; Thu, 05 Nov 2015 08:22:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource_com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:content-type:mime-version:content-transfer-encoding;
        bh=xBAkobbmEvIY0wcvJIf59mQnmj/cHXgEAMAjpjlmGTY=;
        b=O5dPfLS+Mrcmox30EHnrB7FPrlplK4Kw8vkvOa7bC/aU48v2uvWs6/LvNFpz7glOsn
         bSDv0V9Bm1GQ1MNdKQGl016ja7bryguAf8Q9QmtmjrryuvBmfvybpZUoMJP7HbdkRXuU
         ssUHN49SmP/UAiAUbIeSNb3SbD7EMmsoW83jLfHiKCSHHt6Be7ljfXPcnhphxQ9Rm59c
         XSNiX+bFdGzleNyfahbujA9+LJfY5g+iWsILWmNxF8Ie8s0gLzXYpGf73mDsoMw8lY32
         nG3PBxELQi+6WSa8WqMWqPQEh5y/Xswcevtm96UYbbJt9rgWFBtR15aZheHlFZuVlZBt
         yPxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=xBAkobbmEvIY0wcvJIf59mQnmj/cHXgEAMAjpjlmGTY=;
        b=huC5tIEHm9DQ2c4d55JebIqCF3CP/j901eClU/Ytnga3VAvqHrgAneSO9flTYgxoPZ
         I8FVMmqdUrn6sk7LbFgfxrVKuQJsqOCFkMbEAK0GWMZ78MkeeDozWY7oJwZMocXccEiq
         RHDOM1W4plt+FiVY2jDKiX/0e+2vGFBKoFK6pcDwLPoI6V8g2c70LttckSrgFOYLoskW
         x+izbZPVlSIw4kVQ4vupjy4sYz4kf4t2cYDwgk0i3FY77eBva+Oq4o04HHpaN2CIhFvq
         dVMoffKhZI0SOZ5CQdKx62CB6VVZPT317XoepimqVvJJDgh8WrnUyTTItsOFWnktOB9Y
         3U4Q==
X-Gm-Message-State: ALoCoQktuM5kIVcJQGQ1+dONRea5mRt6iq4UCkE2EoFACc9UWWKxQZgyh7M1jphHRhwAvypaz8GM
X-Received: by 10.55.77.4 with SMTP id a4mr8041880qkb.54.1446740537121;
        Thu, 05 Nov 2015 08:22:17 -0800 (PST)
Received: from ubuntu (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id m23sm1802380qkh.46.2015.11.05.08.22.15
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Nov 2015 08:22:16 -0800 (PST)
In-Reply-To: <563AD452.2030301@alum.mit.edu>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280924>

On Thu, 2015-11-05 at 05:00 +0100, Michael Haggerty wrote:
> On 11/04/2015 10:01 PM, David Turner wrote:
> > On Tue, 2015-11-03 at 08:40 +0100, Michael Haggerty wrote:
> >> + * extras and skip must be sorted lists of reference names. Either one
> >> + * can be NULL, signifying the empty list.
> >> + */
> > 
> > My version had:
> > 
> > "skip can be NULL; extras cannot."
> > 
> > The first thing that function does is:
> > string_list_find_insert_index(extras, dirname, 0)
> > 
> > And that crashes when extras is null.  So I think my version is correct
> > here.
> 
> We're talking about the function find_descendant_ref(), which was added
> in this patch, right? Because the first thing that function does is
> 
> +	if (!extras)
> +		return NULL;
> 
> (This guard was in your version, too.) Also, the callsite doesn't
> protect against extras==NULL. So either we're talking about two
> different things here, or I disagree with you.

You're right.  I totally missed that.  But while looking at it, I
noticed that the commit message doesn't look quite right (my fault):

> Create new function verify_no_descendants, to hold one of the ref
> conflict checks used in verify_refname_available. Multiple backends
> will need this function, so move it to the common code.

The function is find_descendant_ref not verify_no_descendants.
