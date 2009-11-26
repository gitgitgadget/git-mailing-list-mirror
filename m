From: Thomas Singer <thomas.singer@syntevo.com>
Subject: Re: [egit-dev] Re: jgit problems for file paths with non-ASCII	characters
Date: Thu, 26 Nov 2009 14:09:09 +0100
Message-ID: <4B0E7DF5.9040007@syntevo.com>
References: <4B0D356D.1080709@syntevo.com> <200911252211.55137.robin.rosenberg@dewire.com> <20091126005423.GM11919@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: EGit developer discussion <egit-dev@eclipse.org>,
	Marc Strapetz <marc.strapetz@syntevo.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Nov 26 14:08:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDe5J-0007hW-5a
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 14:08:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760170AbZKZNIT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Nov 2009 08:08:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758084AbZKZNIS
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Nov 2009 08:08:18 -0500
Received: from syntevo.com ([85.214.39.145]:46371 "EHLO syntevo.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752437AbZKZNIS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Nov 2009 08:08:18 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1]) with ESMTP id 0C99A37C7B0
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <20091126005423.GM11919@spearce.org>
X-Enigmail-Version: 0.96.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133793>

> But as you said, this still doesn't make the Apple normal form
> any easier.  Though if we know we are on such a strange filesystem
> we might be able to assume the paths in the repository are equally
> damaged.  Or not.

Well, if the git-core folks could standardize on, e.g., composed UTF-8
(rather then just UTF-8), for storing file names in the repository, then
everything should be clear, isn't it?

--
Best regards,
Thomas Singer
=============
syntevo GmbH
http://www.syntevo.com
http://blog.syntevo.com


Shawn O. Pearce wrote:
> Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
>> onsdag 25 november 2009 14:47:25 skrev  Marc Strapetz:
>>> I have noticed that jgit converts file paths to UTF-8 when querying the
>>> repository.
> ...
>>> Is this a bug or a misconfiguration of my repository? I'm using jgit
>>> (commit e16af839e8a0cc01c52d3648d2d28e4cb915f80f) on Windows.
>> A bug. 
>>
>> The problem here is that we need to allow multiple encodings since there
>> is no reliable encoding specified anywhere.
> 
> This is a design fault of both Linux and git.  git gets a byte
> sequence from readdir and stores that as-is into the repository.
> We have no way of knowing what that encoding is.  So now everyone
> touching a Git repository is screwed.
> 
>> The approach I advocate is
>> the one we use for handling encoding in general. I.e. if it looks like UTF-8,
>> treat it like that else fallback. This is expensive however
> 
> We should try to work harder with the git-core folks to get character
> set encoding for file names worked out.  We might be able to use a
> configuration setting in the repository to tell us what the proper
> encoding should be, and if not set, assume UTF-8.
> 
>> and then we have
>> all the other issues with case insensitive name and the funny property that
>> unicode has when it allows characters to be encoding using multiple sequences
>> of code points as empoloyed by Apple.
> 
> But as you said, this still doesn't make the Apple normal form
> any easier.  Though if we know we are on such a strange filesystem
> we might be able to assume the paths in the repository are equally
> damaged.  Or not.
> 
