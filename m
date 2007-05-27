From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH v3] Prevent megablobs from gunking up git packs
Date: Sat, 26 May 2007 23:15:16 -0400 (EDT)
Message-ID: <alpine.LFD.0.99.0705262304200.3366@xanadu.home>
References: <465887AB.1010001@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Dana How <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 27 05:15:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hs9EH-0003nh-Ma
	for gcvg-git@gmane.org; Sun, 27 May 2007 05:15:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753258AbXE0DPb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 May 2007 23:15:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752917AbXE0DPb
	(ORCPT <rfc822;git-outgoing>); Sat, 26 May 2007 23:15:31 -0400
Received: from relais.videotron.ca ([24.201.245.36]:61963 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752721AbXE0DPa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 May 2007 23:15:30 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JIO00ELZJPGNPA0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 26 May 2007 23:15:16 -0400 (EDT)
In-reply-to: <465887AB.1010001@gmail.com>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48514>

On Sat, 26 May 2007, Dana How wrote:

> 
> Extremely large blobs distort general-purpose git packfiles.
> These megablobs can be either stored in separate "kept" packfiles,
> or left as loose objects.  Here we add some features to help
> either approach.
> 
> This patch implements the following:
> 1. git pack-objects accepts --max-blob-size=N,  with the effect that
>    only loose blobs less than N KB are written to the packfiles(s).
>    If an already packed blob violates this limit (perhaps these are
>    fast-import packs or max-blob-size was reduced),  it _is_ passed
>    through if from a local pack and no loose copy exists.

I'm still not convainced by this feature.  Is it really necessary?

Wouldn't it be better if the --max-blob-size=N was instead a 
--trailing-blob-size=N to specify which blobs are considered "naughty" 
per our previous discussion? This way there is no incoherency with 
already packed blobs larger than the treshold that you have to pass 
through.

This, combined with the option to disable deltification of large blobs 
(both options can be specified with the same size), and possibly the 
pack size limit, would solve your large blob issue, shouldn't it?


Nicolas
