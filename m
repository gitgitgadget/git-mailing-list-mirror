From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv8 5/9] submodule-config: introduce
 parse_generic_submodule_config
Date: Fri, 5 Feb 2016 17:23:06 -0800
Message-ID: <20160206012306.GD28749@google.com>
References: <1454623776-3347-1-git-send-email-sbeller@google.com>
 <1454623776-3347-6-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, Jens.Lehmann@web.de
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sat Feb 06 02:23:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRrak-0006VS-D4
	for gcvg-git-2@plane.gmane.org; Sat, 06 Feb 2016 02:23:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751132AbcBFBXK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2016 20:23:10 -0500
Received: from mail-pa0-f53.google.com ([209.85.220.53]:33719 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750748AbcBFBXJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2016 20:23:09 -0500
Received: by mail-pa0-f53.google.com with SMTP id cy9so42714605pac.0
        for <git@vger.kernel.org>; Fri, 05 Feb 2016 17:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=ClCftmChrx17NnnyGBB1cs2YNd2aKbwye5uG8/CDlhQ=;
        b=ZVP59LvxQYb+DGehe2LqKPhKlQyhKoyeOgGEiYzpAKwWftvkPQnkwlbAfmFMZfSezl
         mib8VoLspcmyM5G0P6S6jif8mma1Wo2c3GIqPl8QnCppJj39ZlF6dTxg6uNXe5Wqreic
         TDChCsEOLAi0LvkevmugSsgpW9wstcSpOv7bT1DJZYCaomCSaTtJDNgfbW6poa+VrAgh
         r7Ta9IxoGKX/35h89kf4VAXZouoYRcw4aU2eIciHmh8DAA2WH7sNX/ZwM487/8zNgh2f
         WiaP9N/bf8h5PFiaDdO1zGCZx+hj+mHnFE8hiYJPQqmKRcumrbu5yx/CbCbsXHcW94h6
         Kzfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=ClCftmChrx17NnnyGBB1cs2YNd2aKbwye5uG8/CDlhQ=;
        b=hp4uFNLjGHARd6LBExkjkcbYxNiUPX2OAEp/qTqQ2r24+oV3mQRLYBzaj7fCtyJmEf
         dSCxK4EFziBybFG94ps/2X4Bi+q9fK1vDj6bHlXxVtO1wvoe+cQfocA1/i8G3QN6+h9q
         M5MZdj/RouDl1X63uwXFN4z1LnrsSZFCOGsyJALKdohxI9fhwqQVuHIyJY4i+TexESiu
         14PveH/SJdsNz2142e5dYNA2//jpWg2/m7LPNbmxaQDpyBIbmvNBLXKWy6ZbKyclNtXj
         7xG9egZ+ZKNcRTNf+4OujUVU6udBsmEvEsbjX0i+z/nwUg8SPP6pmphpNR16/BvvueXt
         A3Wg==
X-Gm-Message-State: AG10YOQmtgS+Ji8mVnSFkFcIk94Zh+mLHtXo5L01pWlgc+4Fsjqh+jjCPv2lJ6xXJhnd8A==
X-Received: by 10.67.14.168 with SMTP id fh8mr24244951pad.11.1454721788715;
        Fri, 05 Feb 2016 17:23:08 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:d5a0:f713:2934:4c2])
        by smtp.gmail.com with ESMTPSA id ud8sm20174274pac.11.2016.02.05.17.23.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 05 Feb 2016 17:23:08 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1454623776-3347-6-git-send-email-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285663>

Hi,

Stefan Beller wrote:

> This rewrites parse_config to distinguish between configs specific to
> one submodule and configs which apply generically to all submodules.
> We do not have generic submodule configs yet, but the next patch will
> introduce "submodule.fetchJobs".

Does this mean that options like submodule.fetchJobs can be specified
in either .gitmodules or .git/config, like the submodule.<name>.*
options?

I would expect a good value for fetchJobs to be machine-specific.
Would it work to put the submodule.fetchJobs handling in
submodule.c::submodule_config alongside fetch.recurseModules instead?

Thanks,
Jonathan
