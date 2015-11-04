From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v6 25/25] refs: break out ref conflict checks
Date: Wed, 04 Nov 2015 16:01:24 -0500
Organization: Twitter
Message-ID: <1446670884.4131.42.camel@twopensource.com>
References: <cover.1446534991.git.mhagger@alum.mit.edu>
	 <3060e6410e8798064ef84cd31645021d1b84fbb9.1446534991.git.mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Nov 04 22:01:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zu5BU-0006SL-PW
	for gcvg-git-2@plane.gmane.org; Wed, 04 Nov 2015 22:01:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030691AbbKDVB2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2015 16:01:28 -0500
Received: from mail-qk0-f171.google.com ([209.85.220.171]:32911 "EHLO
	mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030264AbbKDVB1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2015 16:01:27 -0500
Received: by qkas77 with SMTP id s77so21656960qka.0
        for <git@vger.kernel.org>; Wed, 04 Nov 2015 13:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource_com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:content-type:mime-version:content-transfer-encoding;
        bh=/tpfKgQV3wepcNYQzMwmgs0tGgEo7MpkTEd6AZqzQWg=;
        b=mQjpdHkiT0asGuTbkle8/oPJ+Ww/56c+vYdc0vunkhHkFvvZSLO3s9m+Mk6xhgl9ob
         dgZrdyvWOpJrnzCPzSQ9c8o2+CM0fP7ayHfLFqDYbLx6k/WaANqjaeuB1w+a5ttpBSAP
         oq3WYUm3nBn4zvj3v59A6Kd8nzv1fQkS0cGz9gthXuFFecK1GFkAL3WHlU30l0DlQbCp
         UmYmBu8v0Bx3gQicNYVDaU67ClOGsZjin2Z9emG9cEkHkLhT3HeNr4wvO81jw3Ive+qQ
         Anwzmf/reYvo73OYwMghUEqH8kQusAimiN5SrDEbmOzRyn258PHOJy3mutt5loHVii6u
         2x9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=/tpfKgQV3wepcNYQzMwmgs0tGgEo7MpkTEd6AZqzQWg=;
        b=a7+B4wd5Blt9mBClbzTqGcInUTI6NZNhCsoFdgO9XroSU5gxjtuyXxxjhNmPmnhp2Q
         n3aL10G0a3flfBJA8hxt2dS6YyYbzMi3gJCYVOfKXo45kr43IOTlGj5CbqO42ZcRJYmq
         D9AzMh/k04tEDTytoWLnhgWVJncPxdpkpZi9Wg23macTZ8DpuWkIYbNN5XruC3482vKh
         12RnAUzNpsEMKmWBvMYkZtub3WGLk0VrLEC/lwz99Si7bsStivs/1slhB792Wf5WvNMY
         8We2gHg0lPzA57IQeROdhfVrljICwHXKJLXuDkwAbEZ/UjJvhIoca8tF2Omr3Gxc61Y7
         PHxA==
X-Gm-Message-State: ALoCoQkbbUdj7v/kXyDFLZlTer8L7Z2alWWIKjxIQj6pyyM0FkRhM1dcBTBba8WNjd0VtXMpnafJ
X-Received: by 10.55.41.32 with SMTP id p32mr3803615qkh.18.1446670886033;
        Wed, 04 Nov 2015 13:01:26 -0800 (PST)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id i71sm782481qhc.44.2015.11.04.13.01.24
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Nov 2015 13:01:25 -0800 (PST)
In-Reply-To: <3060e6410e8798064ef84cd31645021d1b84fbb9.1446534991.git.mhagger@alum.mit.edu>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280883>

On Tue, 2015-11-03 at 08:40 +0100, Michael Haggerty wrote:
> + * extras and skip must be sorted lists of reference names. Either one
> + * can be NULL, signifying the empty list.
> + */

My version had:

"skip can be NULL; extras cannot."

The first thing that function does is:
string_list_find_insert_index(extras, dirname, 0)

And that crashes when extras is null.  So I think my version is correct
here.

Other than that, I've reviewed both the patches themselves and the
overall diff and everything looks good to me.
