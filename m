From: Stefan Beller <sbeller@google.com>
Subject: Re: RFC: Resumable clone based on hybrid "smart" and "dumb" HTTP
Date: Wed, 10 Feb 2016 12:23:06 -0800
Message-ID: <CAGZ79kZMvxa5Np4GbShv_A6NZwVAqff94+d8MFTZwrZS+2CqeQ@mail.gmail.com>
References: <CAJo=hJtHgE_vye_1sPTDsvJ0X=Cs72HKLgRH8btpW-pMrDdk9g@mail.gmail.com>
	<CAJo=hJuRxoe6tXe65ci-A35c_PWJEP7KEPFu5Ocn147HwVuo3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Feb 10 21:23:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTbIA-0003c2-DP
	for gcvg-git-2@plane.gmane.org; Wed, 10 Feb 2016 21:23:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753670AbcBJUXK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Feb 2016 15:23:10 -0500
Received: from mail-ig0-f173.google.com ([209.85.213.173]:35397 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753658AbcBJUXH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Feb 2016 15:23:07 -0500
Received: by mail-ig0-f173.google.com with SMTP id hb3so21973350igb.0
        for <git@vger.kernel.org>; Wed, 10 Feb 2016 12:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=XYuyVQ6thjeyKoHLKWtZgfO25oorz9Sp7ZCnxL7UXPU=;
        b=VjQ/1zWRARw5Sk4Rcwqphss4K6SKAn7i9umQ0Qo2QGpb7AUjx8gF2xA1Bpb7bXIbZa
         Jw3jz8YSRu73wGSoTp9Y4CRhu+QF4raMQI8aQWd+cTKTX5mukSkcQXhJUCp4hazjSYlV
         OsjzfQ89dD+UPlj2kfefAcBnpnfo4yXEU9ptHfJDgVKC28wXv23y5nLXtsMsm3fzExx9
         xN9VtwmCKnp7VHdFop5/6ER4K0+64mprEeZyg3oWz8m33DxzvyfFLg61knPQRLDpElmu
         5zETtbXr7QhShmixQBGyMhNcuINW8jP0jRuCpci+s5tHXt+/zsnRQspvCB2FbE3MdV6M
         ws6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=XYuyVQ6thjeyKoHLKWtZgfO25oorz9Sp7ZCnxL7UXPU=;
        b=OZT/eBhvErOT6DJ9dBHY6gr7OdQeiqLcr2POe6WGDX2xNIWjoOz/j1UcjfhYj13e+9
         f+M/C3wY8jBg80KVvm8buYT5WYeh0Mdna38XZd5Am3Ogxgp1xya9wnxZEGPjFuA4n7/A
         P7UChRVONXuJz+yhyD+UQxecswOO5z3oWorx6s+Ou720w0/fuNmAZQFDHnVcXtsHyoUJ
         skbSBp2/HtI3G7VRRiMczxAenFBx0/p2TIqM5cswVNaGRGcho80hmXJOrIVkw9SrQiE+
         vgR/QqWpx1YoUFQqGFnkWHR2hhTlva3+CCrvCdKM+eNv+Hphl5S8FbSL8uvqhiPwKn6o
         zmDQ==
X-Gm-Message-State: AG10YOTzSvOJIpYot1UP342A6jMkLbIpaH2pA2RZ2hcSDqTqMUFkQYOC0juR+yrmx61mWExJxnYlbpUvj7BwrUoU
X-Received: by 10.50.176.195 with SMTP id ck3mr12802674igc.94.1455135786269;
 Wed, 10 Feb 2016 12:23:06 -0800 (PST)
Received: by 10.107.4.210 with HTTP; Wed, 10 Feb 2016 12:23:06 -0800 (PST)
In-Reply-To: <CAJo=hJuRxoe6tXe65ci-A35c_PWJEP7KEPFu5Ocn147HwVuo3A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285924>

On Wed, Feb 10, 2016 at 12:11 PM, Shawn Pearce <spearce@spearce.org> wrote:
> On Wed, Feb 10, 2016 at 10:59 AM, Shawn Pearce <spearce@spearce.org> wrote:
>>
>> ... Thoughts?
>
> Several of us at $DAY_JOB talked about this more today and thought a
> variation makes more sense:
>
> 1. Clients attempting clone ask for /info/refs?service=git-upload-pack
> like they do today.
>
> 2. Servers that support resumable clone include a "resumable"
> capability in the advertisement.

like "resumable-token=hash" similar to a push cert advertisement?

>
> 3. Updated clients on clone request GET /info/refs?service=git-resumable-clone.

Or just in the non-http case, they would terminate after the ls-remote
(including capability advertisement) was done and connect again to
a different service such as git-upload-stale-pack with the resumable
token to identify the pack.

>
> 4. The server may return a 302 Redirect to its current "mostly whole"
> pack file. This can be more flexible than "refs/heads/*", it just
> needs to be a mostly complete pack file that contains a complete graph
> from any arbitrary roots.
>
> 5. Clients fetch the file using standard HTTP GET, possibly with
> byte-ranges to resume.

In the non-http case the git-upload-stale-pack would be rsync with the
resume token to determine the file name of the pack,
such that we have resumeability.

>
> 6. Once stored and indexed with .idx, clients run `git fsck
> --lost-found` to discover the roots of the pack it downloaded. These
> are saved as temporary references.

jrn:
> I suspect we can do even faster by making index-pack do the work

    index-pack --check-self-contained-and-connected

>
> 7. Client runs incremental fetch, and then deletes the temporary
> references from 6.
>
>
> An advantage to this process is its much more flexible for the server.
> There is no additional pack-*.info file required. GC can organize
> packs anyway it wants, etc.
>
> To make step 4 really resume well, clients may need to save the first
> Location header it gets back from
> /info/refs?service=git-resumable-clone and use that on resume. Servers
> are likely to embed the pack SHA-1 in the Location header, and the
> client wants to use this on subsequent GET attempts to abort early if
> the server has deleted the pack the client is trying to obtain.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
