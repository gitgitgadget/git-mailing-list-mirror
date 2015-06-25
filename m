From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v2 3/6] bisect: use refs infrastructure for BISECT_START
Date: Thu, 25 Jun 2015 19:21:30 -0400
Organization: Twitter
Message-ID: <1435274490.7900.19.camel@twopensource.com>
References: <1435265110-6414-1-git-send-email-dturner@twopensource.com>
	 <1435265110-6414-3-git-send-email-dturner@twopensource.com>
	 <xmqq616by0h3.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 26 01:21:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8GSj-0004ga-1S
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jun 2015 01:21:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751557AbbFYXVf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2015 19:21:35 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:34008 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751426AbbFYXVe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2015 19:21:34 -0400
Received: by igcsj18 with SMTP id sj18so20227886igc.1
        for <git@vger.kernel.org>; Thu, 25 Jun 2015 16:21:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=rvPJ7zNok/GaFqYkH/ElyLrYL8X8/vf23XTHq1C4Pog=;
        b=BO5FRx1mSR8P/c+mRY8qibwqamF1GLgBpTk8vp6ksbhWks32/svRmlEbFQmgQBos0g
         zwdnXt/9qhJ8HH8Ed0h+a21wjyJUIb8YPa+31hxH3rHlfBU0YXcaDJsC8O12JL/NI7Pg
         yhtiMc7IqM7rBNScZ7sQMFh/iabqwfxZy7NQeZdk9x29Js6OcRXjltVNmw+SqKAVx8D5
         hXS/YmoEMJjcgx/S+jBF298uRtbCk/75WBIZRBd8UeXCfwTsuw9hTO1MZ1aMZt79xRTX
         uFVjq/X5J7Wo9Hzm6qaMRgXYXvuoqAtLV+Cp4km9QZUFOW8ApIZNxypNx3DYiwnaawPW
         VRJw==
X-Gm-Message-State: ALoCoQlNzL0RRBpcoc0jfNfTsv+fB3aaejb0QAAujU2IQJGs7wEOkIBwKEnuo8zTdi51PDcd8dS+
X-Received: by 10.43.163.129 with SMTP id mo1mr48111icc.61.1435274493882;
        Thu, 25 Jun 2015 16:21:33 -0700 (PDT)
Received: from ubuntu (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by mx.google.com with ESMTPSA id h2sm2641021igv.2.2015.06.25.16.21.32
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jun 2015 16:21:33 -0700 (PDT)
In-Reply-To: <xmqq616by0h3.fsf@gitster.dls.corp.google.com>
X-Mailer: Evolution 3.12.10-0ubuntu1~14.10.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272744>

On Thu, 2015-06-25 at 13:52 -0700, Junio C Hamano wrote:
> David Turner <dturner@twopensource.com> writes:
> 
> > This ref needs to go through the refs backend, since some code assumes
> > that it can be written and read as a ref.
> 
> And the reason why BISECT_HEAD cannot be treated as a ref, but must
> be treated as a file under $GIT_DIR, is...?

After running some tests on the long version of the series, we can and
should move it into the backend; will add a patch to the next reroll
