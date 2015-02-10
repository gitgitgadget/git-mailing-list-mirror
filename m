From: matthew sporleder <msporleder@gmail.com>
Subject: Re: low memory system to clone larger repo
Date: Mon, 9 Feb 2015 21:56:48 -0600
Message-ID: <CAHKF-At1ybThZ54yNJZQDWooMcLPeCi-QKAi4AjzZyiK86_dOA@mail.gmail.com>
References: <CAHKF-AspyE84_0CVMz2OjFLt3Q62qKDfTkbUk3-+RQ_EZ=0JGg@mail.gmail.com>
	<CACsJy8A=6m5sWnDhPPMNrWbZ=fOMXPxO_1GVh-WpHycf5gm+rg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 10 04:56:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YL1wW-0008Ki-4l
	for gcvg-git-2@plane.gmane.org; Tue, 10 Feb 2015 04:56:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760975AbbBJD4v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2015 22:56:51 -0500
Received: from mail-we0-f177.google.com ([74.125.82.177]:57546 "EHLO
	mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756593AbbBJD4u (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2015 22:56:50 -0500
Received: by mail-we0-f177.google.com with SMTP id l61so30898060wev.8
        for <git@vger.kernel.org>; Mon, 09 Feb 2015 19:56:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=zS0LxO1UqIMWafCxoIm9J2TFmVyFUQI21shuk0Voas4=;
        b=YLNgx6DSQZrbDUWTSyZM3DAnbPZ33rCn7Jm94s/PwtWIaHDygfQFaEPBwFlapZvaaG
         6+Pz5uPBlZlm/Dh//0/u7xFnNtARxPMqV/8biCwEM1Sdlcdo7fvvgB2ckUNiixbhUh5D
         JXzXkdcsjyH9vEY7lJkWj289Q00MEvOv1wP6bvFPEn4QLoY73XjVEE5zx6tIQ2hL+7xt
         Dv5pb0s4tqkWCGSxLQy6zt/xg82nXVqrSeNtbXgLaS8URn7SFleWZnw6ZEzDx5z8JVZy
         bK5nZl3Xs2Lxmpj6v4+kJKxIRhK01CJNqholoaCHtxFxSelNq21IatWB7vCAd144ZB1Z
         KE0A==
X-Received: by 10.181.12.105 with SMTP id ep9mr5569507wid.85.1423540608707;
 Mon, 09 Feb 2015 19:56:48 -0800 (PST)
Received: by 10.195.13.14 with HTTP; Mon, 9 Feb 2015 19:56:48 -0800 (PST)
In-Reply-To: <CACsJy8A=6m5sWnDhPPMNrWbZ=fOMXPxO_1GVh-WpHycf5gm+rg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263624>

Below is the output from my index-pack/clone over git://

This is with the recent memory patch applied but testing some less crazy tuning.
--

The corruption of the signal number shows up in google from other
people so I guess it's a lingering bug.

*
git-tests $ git clone git://github.com/jsonn/src
Cloning into 'src'...
remote: Counting objects: 3497569, done.
remote: Compressing objects: 100% (640647/640647), done.
error: index-pack died of signal 9497569), 990.62 MiB | 8.35 MiB/s
fatal: index-pack failed






On Mon, Feb 9, 2015 at 6:32 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Thu, Jan 8, 2015 at 11:10 PM, matthew sporleder <msporleder@gmail.com> wrote:
>> I am attempting to clone this repo: https://github.com/jsonn/src/
>
> This repo has 3.4M objects. Basic book keeping would cost 200MB (in
> practice it'll be higher because I'm assuming no deltas in my
> calculation). On my 64-bit system, it already uses 400+ MB at the
> beginning of delta resolving phase, and is about 500MB during. 32-bit
> systems cost less but I doubt we could keep it within 256 MB limit. I
> think you just need more powerful machines for a repo this size.
>
> Also, they have some large files (udivmodti4_test.c 16MB, MD5SUMS
> 6MB..) These giant files could make index-pack use more memory
> especially if they are deltified. If you repack the repo with
> core.bigFileThreshold about 1-2MB, then clone, you may get a better
> memory consumption, but at the cost of bigger packs.
> --
> Duy
