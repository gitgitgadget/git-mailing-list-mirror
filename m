From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: low memory system to clone larger repo
Date: Mon, 9 Feb 2015 19:32:19 +0700
Message-ID: <CACsJy8A=6m5sWnDhPPMNrWbZ=fOMXPxO_1GVh-WpHycf5gm+rg@mail.gmail.com>
References: <CAHKF-AspyE84_0CVMz2OjFLt3Q62qKDfTkbUk3-+RQ_EZ=0JGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: matthew sporleder <msporleder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 09 13:32:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKnWL-0001tZ-SN
	for gcvg-git-2@plane.gmane.org; Mon, 09 Feb 2015 13:32:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759921AbbBIMcv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2015 07:32:51 -0500
Received: from mail-ie0-f171.google.com ([209.85.223.171]:46879 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759455AbbBIMcu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2015 07:32:50 -0500
Received: by iecar1 with SMTP id ar1so15967498iec.13
        for <git@vger.kernel.org>; Mon, 09 Feb 2015 04:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=0vIq84nmfkWxyjYl3cPVjqLbkIWiJmZyNrb9OWTZu5c=;
        b=x+znk28xs948NIgaTTPz2GAcGb8aCt/6F4uK+RoWkIgFYCHDCoFL5SyAcd8KoJtBCb
         Cm35Ne/WZaVYTFxFow6/aTihj8YkmbH02Z7tE3WlvmlfHColPYG622Fvb4NT5CRpYjuf
         G5/X9pZKZs+lvl6mf/fMKohSn2fgT41P/PvH7BpnzB5RNJj+IMemVgRWntW9AXIZwWLD
         63gKHs8ukPc+iP2KWbQ1ks/UzGrtmGr0+I2pizWEyM3hd4Puihtp+tXMsxSH8wzt+mp5
         NGyJApbuIeCy+QrwBjlGb1Wc22mO+cp2hSgGRTX1zvbZ9Ixkj4sggzxD3hQYQC5D2gw3
         QSzg==
X-Received: by 10.42.83.147 with SMTP id h19mr24783077icl.95.1423485170222;
 Mon, 09 Feb 2015 04:32:50 -0800 (PST)
Received: by 10.107.131.155 with HTTP; Mon, 9 Feb 2015 04:32:19 -0800 (PST)
In-Reply-To: <CAHKF-AspyE84_0CVMz2OjFLt3Q62qKDfTkbUk3-+RQ_EZ=0JGg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263564>

On Thu, Jan 8, 2015 at 11:10 PM, matthew sporleder <msporleder@gmail.com> wrote:
> I am attempting to clone this repo: https://github.com/jsonn/src/

This repo has 3.4M objects. Basic book keeping would cost 200MB (in
practice it'll be higher because I'm assuming no deltas in my
calculation). On my 64-bit system, it already uses 400+ MB at the
beginning of delta resolving phase, and is about 500MB during. 32-bit
systems cost less but I doubt we could keep it within 256 MB limit. I
think you just need more powerful machines for a repo this size.

Also, they have some large files (udivmodti4_test.c 16MB, MD5SUMS
6MB..) These giant files could make index-pack use more memory
especially if they are deltified. If you repack the repo with
core.bigFileThreshold about 1-2MB, then clone, you may get a better
memory consumption, but at the cost of bigger packs.
-- 
Duy
