From: Max Kirillov <max@max630.net>
Subject: Re: [PATCH] setup.c: set workdir when gitdir is not default
Date: Thu, 4 Sep 2014 17:20:15 +0300
Message-ID: <20140904142015.GA8894@wheezy.local>
References: <1409784120-2228-1-git-send-email-max@max630.net>
 <CACsJy8CS3jC54bTh8ySmpAmbQOycMvvnH=yMES0LJQ4zWkqLrA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 04 16:20:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XPXuD-0002yL-5n
	for gcvg-git-2@plane.gmane.org; Thu, 04 Sep 2014 16:20:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751140AbaIDOUw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2014 10:20:52 -0400
Received: from p3plsmtpa07-04.prod.phx3.secureserver.net ([173.201.192.233]:42768
	"EHLO p3plsmtpa07-04.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750803AbaIDOUw (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Sep 2014 10:20:52 -0400
Received: from wheezy.local ([82.181.158.170])
	by p3plsmtpa07-04.prod.phx3.secureserver.net with 
	id n2Li1o00L3gsSd6012LpVT; Thu, 04 Sep 2014 07:20:51 -0700
Content-Disposition: inline
In-Reply-To: <CACsJy8CS3jC54bTh8ySmpAmbQOycMvvnH=yMES0LJQ4zWkqLrA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256447>

On Thu, Sep 04, 2014 at 05:53:34PM +0700, Duy Nguyen wrote:
> On Thu, Sep 4, 2014 at 5:42 AM, Max Kirillov <max@max630.net> wrote:
>>         /* #0, #1, #5, #8, #9, #12, #13 */
>>         set_git_work_tree(".");
> 
> I wonder if we should setenv(GIT_WORK_TREE_) from inside this function
> instead. A quick glance over 'git grep set_git_work_tree' gives me the
> impression that it's safe to do so, and could cover future bugs
> similar to this.

Actually, I've been thinking about just the oppozite: remove
the setenv(GIT_DIR) from the discovery code at all. Because
backend performs the same discovery, and it would find the
same git directory itself. And leave environment variables to
be only set by user.

Currently environment variables are used for both purposes:
user can use them for hacky stuff, and git itself use them
for passing internal information. But, as we can see,
setting the variables can have bigger effect than expected.
When they are set by user, it's ok, let him try, fail and
set some else variable to adapt for his needs. But for git
code there is the discovery routines, lets just use them
always, it will cause a couple of extra (very few) IO calls
but should always give same (correct) result

-- 
Max
