From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: [PATCH v2 00/10] Use a structure for object IDs.
Date: Tue, 10 Mar 2015 19:38:28 -0700
Message-ID: <82A92572-98E5-4911-87A6-DF5377579436@gmail.com>
References: <1425770645-628957-1-git-send-email-sandals@crustytoothpaste.net>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: "repo.or.cz admin team" <admin@repo.or.cz>,
	Git mailing list <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Andreas Schwab <schwab@linux-m68k.org>
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 11 03:38:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVWXe-0004EM-V9
	for gcvg-git-2@plane.gmane.org; Wed, 11 Mar 2015 03:38:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751476AbbCKCie (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2015 22:38:34 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:46947 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751012AbbCKCid (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2015 22:38:33 -0400
Received: by pabli10 with SMTP id li10so7245730pab.13
        for <git@vger.kernel.org>; Tue, 10 Mar 2015 19:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc;
        bh=XhPjyHDF+03/no31wGPzY6ztncjQKtCG9I5T9tYNjJQ=;
        b=JfcFIAZVJhtQ0wmAuaCPi0qtU/+TBkkO4q7kgsLYemlu5PphiDm4jwVEW2I9i77imE
         GfaAj/ygKOp5o95OJa5CWixd7TNrFbzTWobPPWFBk8lpqvgMdqNEeFJ2iDafZFpzlswy
         /BLE1tQ3e+0yDFTp5PIXS9YLNYqGbLUDfvBX8cesaXOCVVpwtIO6/Cbfd1tQ7PGSx3in
         rvC0tMaMPHGcR7mdLRFlxRkrGQwGTfGAB9t3Qu948cIJoadiyjB9tyuA3+TibXOuSYI7
         B6WdtZ0COSZe2N7fnoBnyPQVj1PrdhddTHH1AsnyVyKnTp6Tm7BwQjgvj5xxMyU5sDhH
         1sHA==
X-Received: by 10.66.141.71 with SMTP id rm7mr72076746pab.114.1426041512551;
        Tue, 10 Mar 2015 19:38:32 -0700 (PDT)
Received: from ?IPv6:2002:48c0:ad8d::223:12ff:fe05:eebd? ([2002:48c0:ad8d:0:223:12ff:fe05:eebd])
        by mx.google.com with ESMTPSA id z4sm3063236pdi.90.2015.03.10.19.38.30
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 10 Mar 2015 19:38:31 -0700 (PDT)
In-Reply-To: <1425770645-628957-1-git-send-email-sandals@crustytoothpaste.net>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265291>

On Mar 7, 2015, at 15:23, brian m. carlson wrote:
> This is a patch series to convert some of the relevant uses of  
> unsigned
> char [20] to struct object_id.
>
> brian m. carlson (10):

All patches applied for me (to master) and all tests pass.

Tested-by: Kyle J. McKay


>  Define a structure for object IDs.

Comments in reply to the patch.


>  Define utility functions for object IDs.
>  bisect.c: convert leaf functions to use struct object_id
>  archive.c: convert to use struct object_id
>  zip: use GIT_SHA1_HEXSZ for trailers
>  bulk-checkin.c: convert to use struct object_id
>  diff: convert struct combine_diff_path to object_id
>  commit: convert parts to struct object_id
>  patch-id: convert to use struct object_id
>  apply: convert threeway_stage to object_id

These all look good, the conversions are simple and easy to follow.


On Mar 7, 2015, at 23:43, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>
>> Certain parts of the code have to be converted before others to  
>> keep the
>> patch sizes small, maintainable, and bisectable, so functions and
>> structures that are used across the codebase (e.g. struct object)  
>> will
>> be converted later.  Conversion has been done in a somewhat haphazard
>> manner by converting modules with leaf functions and less commonly  
>> used
>> structs first.
>
> That "leaf-first" approach sounds very sensible.
>
> In the medium term, I wonder if the changes can progress faster and
> in a less error prone way if you first used GIT_SHA1_RAWSZ in places
> that cannot be immediately converted to the struct yet.  That way,
> we will be easily tell by "git grep GIT_SHA1_RAWSZ" how many more
> places need treatment.  I do not know if that is all that useful
> offhand, though.  Those places need to be touched in the second pass
> to use the struct again, after the "s/\[20\]/[GIT_SHA1_RAWSZ]/"
> first pass.

I definitely noticed the leaf-first approach as I was looking through  
the patches where, for example (03/10), this prototype was left  
unchanged:

static int register_ref(const char *refname, const unsigned char *sha1,
                         int flags, void *cb_data)

but its contents got the update leaving it half converted.  As  
mentioned above this makes the patches more manageable, maintainable  
and bisectable.  However, these functions could be converted to take a  
typedef (a quick grep of 'CodingGuidelines' does not mention typedef)  
and perhaps, as Junio mentions above, help the changes progress faster  
by making it easier to find the affected code (e.g. changing or  
removing the typedef would make the compiler find them for you).

For example, if we added this to object.h:

     typedef unsigned char sha1raw_t[GIT_SHA1_RAWSZ];

then the above prototype could be immediately converted to (and this  
does compile and pass all the tests):

static int register_ref(const char *refname, const sha1raw_t sha,
                         int flags, void *cb_data)

So that together with Junio's suggestion above (and perhaps also a  
sha1hex_t type) would help mark everything in the first pass that  
needs to be touched again in the second pass.  (I'm just throwing out  
some typedef names as an example, there may be more preferable names  
to "sha1raw_t" and "sha1hex_t", but those names would end up being  
replaced eventually anyway.)

-Kyle 
