From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 02/22] try_merge_strategy(): remove redundant lock_file
 allocation
Date: Thu, 03 Apr 2014 14:43:01 +0200
Message-ID: <533D5755.7030609@alum.mit.edu>
References: <1396367910-7299-1-git-send-email-mhagger@alum.mit.edu>	<1396367910-7299-3-git-send-email-mhagger@alum.mit.edu>	<20140401195615.GB21715@sigill.intra.peff.net> <xmqqy4znwu4g.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 03 15:27:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WVgz9-00078b-J1
	for gcvg-git-2@plane.gmane.org; Thu, 03 Apr 2014 14:43:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751485AbaDCMnH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Apr 2014 08:43:07 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:56954 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750891AbaDCMnF (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Apr 2014 08:43:05 -0400
X-AuditID: 1207440e-f79c76d000003e2c-44-533d57574ec6
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 3F.A0.15916.7575D335; Thu,  3 Apr 2014 08:43:03 -0400 (EDT)
Received: from [192.168.69.148] (p5B1562A0.dip0.t-ipconnect.de [91.21.98.160])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s33Ch1wm011647
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Thu, 3 Apr 2014 08:43:02 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.3.0
In-Reply-To: <xmqqy4znwu4g.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBKsWRmVeSWpSXmKPExsUixO6iqBsebhts8OuogkXXlW4mi4beK8wW
	P1p6mB2YPZ717mH0uHhJ2ePzJrkA5ihum6TEkrLgzPQ8fbsE7ozFk58wFuwVrfj/9QlLA+NC
	wS5GTg4JAROJ9tfL2SBsMYkL99YD2VwcQgKXGSUu3exggnDOMkls/vOKCaSKV0BbYvLxDYwg
	NouAqsS/ezNZQGw2AV2JRT3NYDWiAkEShzecYoWoF5Q4OfMJWI2IgKPEiQfXgeIcHMwC4hL9
	/8DCwgIREht+3mKF2HWTUeLple1g8zkFrCU2/DjKCFIvAVTf0xgEEmYW0JF41/eAGcKWl9j+
	dg7zBEbBWUi2zUJSNgtJ2QJG5lWMcok5pbm6uYmZOcWpybrFyYl5ealFusZ6uZkleqkppZsY
	ISHNt4Oxfb3MIUYBDkYlHl4LKZtgIdbEsuLK3EOMkhxMSqK8MwJtg4X4kvJTKjMSizPii0pz
	UosPMUpwMCuJ8K6zAsrxpiRWVqUW5cOkpDlYlMR51Zao+wkJpCeWpGanphakFsFkZTg4lCR4
	g8KAGgWLUtNTK9Iyc0oQ0kwcnCDDuaREilPzUlKLEktLMuJBERxfDIxhkBQP0F6jEJC9xQWJ
	uUBRiNZTjLocG7ataWQSYsnLz0uVEuflA9khAFKUUZoHtwKWwF4xigN9LMybA1LFA0x+cJNe
	AS1hAlrCvc4KZElJIkJKqoGRdfPegsK+LS8vfnqU8sH/0ax82YyAz0p8P//48W/fYjihUTsr
	n6W2snWuxWr/lEMJy6c76kx9vcbc5XTxggU7w491zM6fXjtLckHRu9ObvqRXZAjc 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245735>

On 04/02/2014 06:53 PM, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
>> On Tue, Apr 01, 2014 at 05:58:10PM +0200, Michael Haggerty wrote:
>>
>>> By the time the "if" block is entered, the lock_file instance from the
>>> main function block is no longer in use, so re-use that one instead of
>>> allocating a second one.
>>>
>>> Note that the "lock" variable in the "if" block used to shadow the
>>> "lock" variable at function scope, so the only change needed is to
>>> remove the inner definition.
>>
>> I wonder if this would also be simpler if "lock" were simply declared as
>> a static variable, and we drop the allocation entirely. I suppose that
>> does create more cognitive load, though, in that it is only correct if
>> the function is not recursive. On the other hand, the current code makes
>> a reader unfamiliar with "struct lock" wonder if there is a free(lock)
>> missing.
> 
> Another thing that makes a reader wonder if this is a valid rewrite
> is if it is safe to reuse a lock_file structure, especially because
> the original gives a piece of memory _cleared_ with xcalloc().  The
> second invocation of hold_locked_index() is now done on a dirty
> piece of memory, and the reader needs to drill down the callchain to
> see if that is safe (and if not, hold_locked_index() and probably
> the underlying lock_file() needs to memset() it to NULs).

It's good that you and Peff asked questions about this sort of thing.

We reuse lock_file structures *all over the place*; for example, just
search for "static struct lock_file".  It has to be safe...

...and yet it isn't.  Look in the definition of lock_file() (before my
changes):

static int lock_file(struct lock_file *lk, const char *path, int flags)
{
	...
	strcpy(lk->filename, path);
	if (!(flags & LOCK_NODEREF))
		resolve_symlink(lk->filename, max_path_len);
	strcat(lk->filename, ".lock");

Remember that a reused lock_file structure is already in lock_file_list,
and there is already a signal handler registered that will call
remove_lock_file(), which looks like:

static void remove_lock_file(void)
{
	pid_t me = getpid();

	while (lock_file_list) {
		if (lock_file_list->owner == me &&
		    lock_file_list->filename[0]) {
			if (lock_file_list->fd >= 0)
				close(lock_file_list->fd);
			unlink_or_warn(lock_file_list->filename);
		}
		lock_file_list = lock_file_list->next;
	}
}

So, if the process gets a signal during the call to resolve_symlink(),
the atexit() cleanup routine will delete the valuable file (the one
being locked)!

It definitely looks like this area needs more work.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
