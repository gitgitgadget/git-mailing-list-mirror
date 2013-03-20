From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/6] t5516 (fetch-push): introduce mk_test_with_name()
Date: Wed, 20 Mar 2013 11:28:30 -0700
Message-ID: <20130320182830.GJ3655@google.com>
References: <1363783501-27981-1-git-send-email-artagnon@gmail.com>
 <1363783501-27981-4-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 20 19:29:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UINl0-0001kU-R4
	for gcvg-git-2@plane.gmane.org; Wed, 20 Mar 2013 19:29:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757102Ab3CTS2h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Mar 2013 14:28:37 -0400
Received: from mail-pb0-f53.google.com ([209.85.160.53]:33358 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755269Ab3CTS2f (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Mar 2013 14:28:35 -0400
Received: by mail-pb0-f53.google.com with SMTP id un1so1569052pbc.12
        for <git@vger.kernel.org>; Wed, 20 Mar 2013 11:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=GCb52rY8puZXOrmYejFIWcJ2X1DW6b8s4jj+4tLhf6U=;
        b=xaYwbXdCpnLQHJkmJs0AKg1f+jEJZz8Wr0dQ2nKrnJl0Ifq8CB9i0E85ipkL3mXphy
         dYz3uTT9/LLhl31OwhrbaP8RRqJEW45yNpsyg1PVXamx/82xVrtiapsOoaXFt7vvuj7g
         FLNwCuwGV+Dxl/aSfzalxyC2UYS6YjzWpqgTa+qDF1mV0VweB+m2LLM92L0nd8hfkO6k
         A6avEBiC+86VoHt3XGlglRXGtR5JfsTkRktZv/3FJWEWxxzR7fq1z1ls5pzinthBX2Fy
         7NkHOh+yPEw1Kz0NH0+wVb1VnjrJo/U7FLzSrVGbeStgRtK9fVarB/aJzI072bKiB6n/
         9+lQ==
X-Received: by 10.68.136.138 with SMTP id qa10mr10581692pbb.20.1363804114922;
        Wed, 20 Mar 2013 11:28:34 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id zv3sm3167830pab.0.2013.03.20.11.28.32
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 20 Mar 2013 11:28:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1363783501-27981-4-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218639>

Ramkumar Ramachandra wrote:

> mk_test() creates a repository with the constant name "testrepo", and
> this may be limiting for tests that need to create more than one
> repository for testing.  To fix this, create a new mk_test_with_name()
> which accepts the repository name as $1.  Reimplement mk_test() as a
> special case of this function, making sure that no tests need to be
> rewritten.

Why not give mk_test an optional parameter?

	repo_name=${1:-testrepo}

Oh, it is because mk_test already takes arguments naming refs to push.
I suppose the change description could make this clearer.

Why not use mk_test and then rename, like so?

	mk_test ...refs... &&
	mv testrepo testrepo-a &&

	mk_test ...refs... &&
	mv testrepo testrepo-b &&
	...

I dunno.  The helper functions at the top of this test are already
intimidating, so I guess I am looking for a way to avoid making that
problem worse.  One way would be to add an opening comment before
the function definition explaining how it is meant to be used.  See
t/test-lib-functions.sh for examples, such as test_cmp.

Hope that helps,
Jonathan
