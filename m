From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 00/16] Convert parts of refs.c to struct object_id
Date: Sun, 26 Apr 2015 22:26:22 +0200
Message-ID: <553D49EE.4000801@alum.mit.edu>
References: <1429745061-295908-1-git-send-email-sandals@crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: Jeff King <peff@peff.net>, "Kyle J. McKay" <mackyle@gmail.com>,
	Ronnie Sahlberg <sahlberg@google.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 26 22:26:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YmT8N-0002la-OQ
	for gcvg-git-2@plane.gmane.org; Sun, 26 Apr 2015 22:26:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750853AbbDZU0a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Apr 2015 16:26:30 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:43491 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750713AbbDZU03 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Apr 2015 16:26:29 -0400
X-AuditID: 1207440f-f792a6d000001284-22-553d49f2db2f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 06.B4.04740.2F94D355; Sun, 26 Apr 2015 16:26:26 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB0E4D.dip0.t-ipconnect.de [93.219.14.77])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t3QKQNnc023843
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Sun, 26 Apr 2015 16:26:24 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.6.0
In-Reply-To: <1429745061-295908-1-git-send-email-sandals@crustytoothpaste.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIKsWRmVeSWpSXmKPExsUixO6iqPvJ0zbU4O8LaYuuK91MFpf3Lmex
	+NHSw2zxb0KNRdvMH0wOrB7Lb/5l8tg56y67x4JNpR7PevcwenzeJBfAGsVtk5RYUhacmZ6n
	b5fAnXF5XXZBt2LFuiWf2BsYN0l1MXJySAiYSCxqO8EIYYtJXLi3nq2LkYtDSOAyo0TT5WYW
	COcck8SHK4+AMhwcvALaEod2mYM0sAioSrw51cEEYrMJ6Eos6mkGs0UFgiRar00FG8orIChx
	cuYTFhBbRMBLYv6jGawgNrNAkcTstitg9cICnhKt65aDxYUEfCUOT37CBLKKU8BP4uaMQIhy
	PYkd139BtcpLNG+dzTyBUWAWkg2zkJTNQlK2gJF5FaNcYk5prm5uYmZOcWqybnFyYl5eapGu
	iV5uZoleakrpJkZIcPPvYOxaL3OIUYCDUYmHVyLVJlSINbGsuDL3EKMkB5OSKO81A9tQIb6k
	/JTKjMTijPii0pzU4kOMEhzMSiK89a5AOd6UxMqq1KJ8mJQ0B4uSOK/6EnU/IYH0xJLU7NTU
	gtQimKwMB4eSBO8XD6BGwaLU9NSKtMycEoQ0EwcnyHAuKZHi1LyU1KLE0pKMeFCUxhcD4xQk
	xQO0188TZG9xQWIuUBSi9RSjopQ4706QuQIgiYzSPLixsJT1ilEc6Eth3rUgVTzAdAfX/Qpo
	MBPQ4MqZNiCDSxIRUlINjCnb1p9/vyZsyZt/k9Zq3+xUmWKgPnexb9XKfpMf4dVmfO5+fTbe
	Pr/43B3TdWPWxi75vKlzOXeRkaJaKf9Xxsu+B+aVzj2u11xw4vXUMLW/Z2yKN8ef 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267834>

On 04/23/2015 01:24 AM, brian m. carlson wrote:
> This is a conversion of parts of refs.c to use struct object_id.
> 
> refs.c, and the for_each_ref series of functions explicitly, is the
> source for many instances of object IDs in the codebase.  Therefore, it
> makes sense to convert this series of functions to provide a basis for
> further conversions.
> 
> This series is essentially just for_each_ref and friends, the callbacks,
> and callers.  Other parts of refs.c will be converted in a later series,
> so as to keep the number of patches to a reasonable size.
> 
> There should be no functional change from this patch series.

I wanted to review your patches, but wasn't really sure how to go about
it in a way that would make me confident in the result. In a way these
refactoring patch series are easier to implement than to review.

...so that's what I did. I reimplemented your changes "from scratch" [1]
and then checked how my result differed from yours. My conclusion is
that the final result of your patches looks good, though there are some
other changes in the neighborhood that could sensibly be added.


However, I reached the destination via a different route and I thought
I'd describe it in case you are interested, and as the technique might
be useful for future "object_id" refactorings. My patch series is
available on my GitHub account at

    https://github.com/mhagger/git branch oid-refs-adapter

My starting point was to change each_ref_fn to take a "const object_id
*" parameter instead of "const unsigned char *". This change requires
all call sites of all of the for_each_ref functions to be modified,
because they currently pass callback functions that match the old signature.

So I kept the old typedef (the one that takes "const unsigned char *")
but renamed it to each_ref_sha1_fn. And I added an adapter that allows
such functions to be wrapped then passed to the new for_each_ref
functions. It looks like this:

    typedef int each_ref_sha1_fn(const char *refname,
    			         const unsigned char *sha1, int flags, void *cb_data);

    struct each_ref_fn_sha1_adapter {
	    each_ref_sha1_fn *original_fn;
	    void *original_cb_data;
    };

    extern int each_ref_fn_adapter(const char *refname,
			           const struct object_id *oid, int flags, void *cb_data);

Each callsite has to be changed, but the changes are quite
straightforward. At a callsite that would have called

    for_each_ref(my_function, &my_data)

you wrap my_function and my_data in an each_ref_fn_sha1_adapter and call
for_each_ref using each_ref_fn_adapter as the callback:

    struct each_ref_fn_sha1_adapter wrapped_my_function =
            {my_function, &my_data};

    for_each_ref(each_ref_fn_adapter, &wrapped_my_function);

The function each_ref_fn_adapter extracts the SHA-1 out of the oid and
calls my_function, passing it &my_data as extra data.

This patch is thus giant but very straightforward.

After that, there is one patch for each callsite, rewriting it to use
for_each_ref natively (which usually entails modifying my_function to
take an object_id parameter then undoing the wrapper). These patches
involve a little bit of thought, but not too much. And the results are
very bisectable because each patch makes a single small change. I also
suspect it might be easier to rebase and/or merge my patch series, for
the same reason.

The end result was very similar to yours, so I am confident that the net
result of your patch series is correct. But the remaining differences in
the end results are also interesting. I made a few more changes in the
neighborhood of the patches, not to mention a few formatting
improvements in code that I touched. If you compare the tip of my
branch, above, to the tip of yours (I uploaded that to my repo too, as
branch "bc-oid-refs"), it may give you some ideas for other code that
can be changed to object_id.

Yours,
Michael

[1] Obviously I glanced at your patches while I was working to make sure
that I was headed in the same direction as you, and to minimize
gratuitous differences between our versions.

-- 
Michael Haggerty
mhagger@alum.mit.edu
