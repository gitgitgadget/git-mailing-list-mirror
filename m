From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Resumable git clone?
Date: Wed, 2 Mar 2016 08:45:04 +0700
Message-ID: <CACsJy8B6_mRpw7ADyZ3H5vWq=JzEUX0yRHJM7pqQgCPQbvhOwA@mail.gmail.com>
References: <20160302012922.GA17114@jtriplet-mobl2.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>, sarah@thesharps.us,
	viro@zeniv.linux.org.uk
To: Josh Triplett <josh@joshtriplett.org>
X-From: git-owner@vger.kernel.org Wed Mar 02 02:45:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aavrE-000590-2b
	for gcvg-git-2@plane.gmane.org; Wed, 02 Mar 2016 02:45:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755123AbcCBBpi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2016 20:45:38 -0500
Received: from mail-lf0-f54.google.com ([209.85.215.54]:35363 "EHLO
	mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753901AbcCBBpf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2016 20:45:35 -0500
Received: by mail-lf0-f54.google.com with SMTP id j186so51169937lfg.2
        for <git@vger.kernel.org>; Tue, 01 Mar 2016 17:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=jgsDnxBtOlPbrRtGy69WB1k9iOw2yWxiiNB+coVt3XQ=;
        b=Cs/vqg4Rg3S2uG+/b4xTTzM4koTXChhuWpPRFzCLSArl/oc1WCwbHMbo6UJ77ohV1A
         Y9RheMHnpWN8oMK0L6VCxfcAWBqAlpniOkkL5YThq+S3PyAKEgXWHkUk0mWwxu6r43SY
         8uN3NQ4uccM7qWZB/OsmzjYNWT9l97B8aS/gx+HoiHkrLnQzae6ca6YNZfO0d1NyFSjS
         l2j1Prh2+jICFV2olIAZNjIYhcfuLKzU+Vh/Uhvmk1mqoepm6f9qsY3TtSn2dMjxkgFk
         hcpj31+U6JeAryDLtmxFyyn9RvVRhL8FLDf4RO0pd8lct8Z8tdxf37cN68UdFtfd+pOB
         y96g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=jgsDnxBtOlPbrRtGy69WB1k9iOw2yWxiiNB+coVt3XQ=;
        b=kodh77r748W7InIRdf5N8ZK3dPLc6+y9SNpxhB4XE8JorsbGqSftOU+noCSWd3C4kH
         ESRv1JaXYQKMBixaL6n1gIy3Rtk8EfPD3bmwTwz+x9VDn3WM0iU7q4kjH6fe1V/tHhWM
         A4y/yiz2KCP94EyWoP6H/Ae9HPaVLBUc6ERlo8+K/u/pXFG1GAGWUehEAuMqEdF64sWV
         tgUnsRkxvYmVlJh3nLnNMKw0TuO4UVxA+ipep/dqhd0OPby5evJXpAnQd1ovJ8U3Yn07
         Hw77RNZNrhPWP/FG5JyqLJ4TdErnoLDOgNnvRUbjE4gBWKN4VFBAIk4Wsy0WhVGq6NTp
         Lt7Q==
X-Gm-Message-State: AD7BkJJpHqHEWT/x4iqlJV6RChAZG2+xWmVX4G8HryurH/P/i2l2yAVoPWT3Vp3jTACLfQ9jgjv3KgO8UXZLlw==
X-Received: by 10.25.212.213 with SMTP id l204mr4403772lfg.118.1456883133938;
 Tue, 01 Mar 2016 17:45:33 -0800 (PST)
Received: by 10.112.51.99 with HTTP; Tue, 1 Mar 2016 17:45:04 -0800 (PST)
In-Reply-To: <20160302012922.GA17114@jtriplet-mobl2.jf.intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288090>

On Wed, Mar 2, 2016 at 8:30 AM, Josh Triplett <josh@joshtriplett.org> wrote:
> If you clone a repository, and the connection drops, the next attempt
> will have to start from scratch.  This can add significant time and
> expense if you're on a low-bandwidth or metered connection trying to
> clone something like Linux.
>
> Would it be possible to make git clone resumable after a partial clone?
> (And, ideally, to make that the default?)
>
> In a discussion elsewhere, Al Viro suggested taking the partial pack
> received so far, repairing any truncation, indexing the objects it
> contains, and then re-running clone and not having to fetch those
> objects.  This may also require extending receive-pack's protocol for
> determining objects the recipient already has, as the partial pack may
> not have a consistent set of reachable objects.
>
> Before starting down the path of developing patches for this, does the
> approach seem potentially reasonable?

This topic came up recently (thanks Sarah!) and Shawn proposed a
different approach that (I think) is simpler and more effective for
resume _clone_ case. I'm not sure if anybody is implementing it
though.

[1] http://thread.gmane.org/gmane.comp.version-control.git/285921
-- 
Duy
