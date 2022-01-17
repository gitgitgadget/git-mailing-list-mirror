Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D37C433EF
	for <git@archiver.kernel.org>; Mon, 17 Jan 2022 23:09:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243763AbiAQXJU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Jan 2022 18:09:20 -0500
Received: from smtp.zlima12.com ([107.172.191.159]:57484 "EHLO
        smtp.zlima12.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbiAQXJU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jan 2022 18:09:20 -0500
Date:   Mon, 17 Jan 2022 18:09:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zlima12.com; s=dkim;
        t=1642460959; bh=ImHJ0xxE1cWm9ZlPP0R+AtqAuIwkUDixtl1XwChDk+8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=RhXtEddRtJIANakxGihNOZ5B8U5gbAjmaj22nn94yoptkHHEMGh3xJktXAT2I3bxA
         OtirbhzSbmu2RZUT/9eATkkcdNo+aBiag3ZIDhU0Tiw6fKHluBhRiUtfAXHWZX5373
         Yg5dk4tVlKEegNMbmr1qeLvQaKKNvM2vqcrId4imsTABxhgTPzL5x7DbWnt4iGbv9g
         oYBxJEE5JkuIZxjYtoaxQrh3lBuDFcVG6nK3Ej+1txWxA0jkF90wbdAeZ2Ilg51xWa
         OqD0dGXceBwiqzknq0rl8LwyqVWwh5y0YFz8SA8PLfk1P8XbzWUPGkkesa7mOO0CYW
         E8JQqaD0M6cNw==
From:   "John A. Leuenhagen" <john@zlima12.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org
Subject: Re: Behavior of core.sharedRepository on non-bare Repositories
Message-ID: <20220117230827.c4s4kmejk675drf7@Zulu-1>
References: <20220117223912.fwsydwpkwfbcdlcq@Zulu-1>
 <YeXz0MYd8wduM9W+@camp.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YeXz0MYd8wduM9W+@camp.crustytoothpaste.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 17, 2022 at 10:55:12PM +0000, brian m. carlson wrote:
> I can't speak to how this feature is supposed to work on the working
> tree, but it is generally the case that users should not share a working
> tree. Any user who can modify the configuration can cause arbitrary code
> to be executed by every other user of the repository when they run
> almost any Git command.
> 
> The only safe thing to do with an untrusted repository is perform a
> clone or fetch from it.
> 
> It may be in your case that all the users are trusted (e.g., all system
> administrators), but in general it's strongly recommended that users not
> share a working tree.  There'll be an entry in the FAQ describing this
> in the future.

Alright, there should definitely be warnings about this then, I'm glad
something will be added to the FAQ at least.

In my case, I wanted to have a user for the purpose of compiling some
projects. This user would be very unpriviliged, so that the build system
(whether through misconfiguration or malice) couldn't do much harm.

I intended to have a group that my own user and this unpriviliged user
would be in. All files and directories in the working tree would be
owned by this group, and should be group-writable. This way, I could
make edits to source files, but the unpriviliged user could also do what
it needed to while building the project.

> That doesn't mean that this feature couldn't be extended to handle the
> working tree, but I did want to provide some context on why working
> trees aren't intended to be shared.

Of course, thanks for the input. Considering the dangers you mentioned,
perhaps this functionality is better off in a completely separate
option. Or at the least, the description of the feature should be very
descriptive in all of this.
