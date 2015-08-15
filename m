From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 2/4] path: optimize common dir checking
Date: Sat, 15 Aug 2015 14:59:16 +0700
Message-ID: <CACsJy8BCr7StbtcrgsbTiosTX1RkjwwWyRqddz2XDhFn5R+zAw@mail.gmail.com>
References: <1439416645-19173-1-git-send-email-dturner@twopensource.com> <1439416645-19173-2-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Christian Couder <chriscool@tuxfamily.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Sat Aug 15 10:00:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZQWNr-0004lO-IG
	for gcvg-git-2@plane.gmane.org; Sat, 15 Aug 2015 10:00:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751335AbbHOH7q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Aug 2015 03:59:46 -0400
Received: from mail-ob0-f182.google.com ([209.85.214.182]:33375 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751004AbbHOH7q (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Aug 2015 03:59:46 -0400
Received: by obbhe7 with SMTP id he7so77974719obb.0
        for <git@vger.kernel.org>; Sat, 15 Aug 2015 00:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ZvC/h8Ulz/BvT3mYKOIcf0CigNfnLNoCGUoui5UsVNc=;
        b=xFc/4N8Wv4UdLCsvt0mYilHE9fP03HGF6qAPphnEub0PTBJhgCedBF9FODLpx+D1sR
         hJePpNoRULVc4I93XelclOEZiMXLrK4vOgxKjr8apanE8CAmeTw1oO27yn2K1eUl4Bkk
         Obn4JAy+UFxtfWs+YcItqRp9j3u0Hwe615M+jYNhl3flbM8fItlcPLayp9AUsIma20Lr
         NMTugHApHZK7TjcoZwW+cJEnS2I1cZQH51ZOhJru+8zJd8M/NByYox5Q/pLHmivA8r+B
         oTaX2ZUHX/9wy/4P9VIrhCtiSnVdQKnFLxFIaZoXzu2E9MU/bOqbUh4tx30iDRdfhIBr
         hPHw==
X-Received: by 10.60.94.52 with SMTP id cz20mr8477206oeb.8.1439625585554; Sat,
 15 Aug 2015 00:59:45 -0700 (PDT)
Received: by 10.202.52.6 with HTTP; Sat, 15 Aug 2015 00:59:16 -0700 (PDT)
In-Reply-To: <1439416645-19173-2-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275980>

On Thu, Aug 13, 2015 at 4:57 AM, David Turner <dturner@twopensource.com> wrote:
> Instead of a linear search over common_list to check whether
> a path is common, use a trie.  The trie search operates on
> path prefixes, and handles excludes.

Just be careful that the given key from git_path is not normalized. I
think you assume it is in the code, but I haven't read carefully. We
could of course optimize for the good case: assume normalized and
search, then fall back to explicit normalizing and search again.
-- 
Duy
