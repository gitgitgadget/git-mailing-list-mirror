From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/5] Make xstrndup common
Date: Sat, 28 Apr 2007 15:47:21 -0700
Message-ID: <7vslaki0au.fsf@assigned-by-dhcp.cox.net>
References: <46339819.8030007@freedesktop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>
To: Josh Triplett <josh@freedesktop.org>
X-From: git-owner@vger.kernel.org Sun Apr 29 00:47:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhvhO-0007tL-44
	for gcvg-git@gmane.org; Sun, 29 Apr 2007 00:47:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754267AbXD1WrX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Apr 2007 18:47:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754283AbXD1WrX
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Apr 2007 18:47:23 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:57271 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754267AbXD1WrW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Apr 2007 18:47:22 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070428224722.IHVU16514.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Sat, 28 Apr 2007 18:47:22 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id smnM1W0071kojtg0000000; Sat, 28 Apr 2007 18:47:21 -0400
In-Reply-To: <46339819.8030007@freedesktop.org> (Josh Triplett's message of
	"Sat, 28 Apr 2007 11:53:13 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45800>

Josh Triplett <josh@freedesktop.org> writes:

> Daniel Barkalow wrote:
>> It was implemented in commit.c; move it with the other x memory functions.
> [...]
>> +static inline char *xstrndup(const char *str, int len)
>> +{
>> +	char *ret = xmalloc(len + 1);
>> +	memcpy(ret, str, len);
>> +	ret[len] = '\0';
>> +	return ret;
>> +}
>> +
>
> I don't know if it matters, but this definition of xstrndup, like the version
> in commit.c, doesn't match the definition of strndup.  strndup duplicates a
> string, copying up to n characters or the length of the string.  This xstrndup
> always copies n characters, reading past the end of the string if it doesn't
> have at least n characters.

Very well caught indeed, thanks.  In the original context in
commit.c, this function is always given length computed by
inspecting the source text by the caller, so the code was
correct, but if we are making it available as a general utility
routine, we probably cannot depend on that assumption anymore.
