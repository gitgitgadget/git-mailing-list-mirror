From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Migrating away from SHA-1?
Date: Thu, 14 Apr 2016 10:28:50 -0700
Message-ID: <71A5D062-FCCD-42E5-80A8-AA9D8DE20604@zytor.com>
References: <570D78CC.9030807@zytor.com> <CAGZ79kaUN0G7i0GNZgWU7ZzJvWY=k=Rc6tqWvJsTu8gcRhP5bA@mail.gmail.com> <1460502934.5540.71.camel@twopensource.com> <20160414015324.GA16656@thunk.org> <1460654583.5540.87.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>,
	"Theodore Ts'o" <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Thu Apr 14 19:29:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aql4n-0001sQ-Pq
	for gcvg-git-2@plane.gmane.org; Thu, 14 Apr 2016 19:29:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932420AbcDNR26 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2016 13:28:58 -0400
Received: from terminus.zytor.com ([198.137.202.10]:60686 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755290AbcDNR25 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2016 13:28:57 -0400
Received: from [IPv6:2607:fb90:426:71bc:84b8:f66e:3cdd:27bf] ([IPv6:2607:fb90:426:71bc:84b8:f66e:3cdd:27bf])
	(authenticated bits=0)
	by mail.zytor.com (8.15.2/8.14.5) with ESMTPSA id u3EHSqJB027870
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 14 Apr 2016 10:28:53 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <1460654583.5540.87.camel@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291538>

On April 14, 2016 10:23:03 AM PDT, David Turner <dturner@twopensource.com> wrote:
>On Wed, 2016-04-13 at 21:53 -0400, Theodore Ts'o wrote:
>> On Tue, Apr 12, 2016 at 07:15:34PM -0400, David Turner wrote:
>> > 
>> > If SHA-1 is broken (in certain ways), someone *can* replace an
>> > arbitrary blob.  GPG does not help in this case, because the
>> > signature
>> > is over the commit object (which points to a tree, which eventually
>> > points to the blob), and the commit hasn't changed.  So the GPG
>> > signature will still verify.
>> 
>> The "in certain ways" is the critical bit.  The question is whether
>> you are trying to replace an arbitrary blob, or a blob that was
>> submitted under your control.
>> 
>> If you are trying to replace an arbitrary blob under the you need to
>> carry a preimage attack.  That means that given a particular hash,
>> you
>> need to find another blob that has the same hash.  SHA-1 is currently
>> resistant against preimage attack (that is, you need to use brute
>> force, so the work factor is 2**159).  
>> 
>> If you are trying to replace an arbitrary blob which is under your
>> control, then all you need is a collision attack, and this is where
>> SHA-1 has been weakened.  It is now possible to find a collision with
>> a work factor of 2**69, instead of the requisite 2**80.
>> 
>> It was a MD5 collision which was involved with the Flame attack.
>> Someone (in probably the US or Isreali intelligence services)
>> submitted a Certificate Signing Request (CSR) to the Microsoft
>> Terminal Services Licensing server.  That CSR was under the control
>> of
>> the attacker, and it resulted in a certificate where parts of the
>> certificate could be swapped out with the corresponding fields from
>> another CSR (which was not submitted to the Certifiying Authority)
>> which had the code signing bit set.
>> 
>> So in order to carry out this attack, not only did the (cough)
>> "unknown" attackers had to have come up with a collision, but the two
>> pieces of colliding blobs had to parsable a valid CSR's, one which
>> had
>> to pass inspection by the automated CA signing authority, and the
>> other which had to contain the desired code signing bits set so the
>> attacker could sabotage an Iranian nuclear centrifuge.
>> 
>> OK, so how does this map to git?  First of all, from a collision
>> perspective, the two blobs have to map into valid C code, one of
>> which
>> has to be innocuous enough such that any humans who review the patch
>> and/or git pull request don't notice anything wrong.  
>
>It looks like Linux contains at least some firmware which would be hard
>to audit.  One random example is:
>firmware/bnx2x/bnx2x-e1h-6.2.9.0.fw.ihex

Either way, I agree with Ted, that we have enough time to do it right, but that is a good reason to do it sooner rather than later (see also my note about freezing the cryptographic properties.)
-- 
Sent from my Android device with K-9 Mail. Please excuse brevity and formatting.
