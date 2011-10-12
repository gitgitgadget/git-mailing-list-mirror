From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH v4] attr.c: respect core.ignorecase when matching attribute
 patterns
Date: Wed, 12 Oct 2011 15:18:34 -0500
Message-ID: <y0zSE7mQNTqQ3B_hRG_UvK2pQCTYIP8jr_bGkjb8qdCqyfJ544ZQhQCmwkL-_MxlparVZWmDgqL7VO68y3trgjciKw2QRAK_j7KNVcXXJW0@cipher.nrlssc.navy.mil>
References: <4E93BBA8.6080403@alum.mit.edu> <xdU4uj1WkogEVU_JDz3kmxkX_eFz1cDWrEbnJirB8aZT-27u7JCY41omRSEEBC62anWl8YRgN2o@cipher.nrlssc.navy.mil> <7v8vorh3kg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu,
	Brandon Casey <drafnel@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 12 22:18:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RE5GJ-0005To-Se
	for gcvg-git-2@lo.gmane.org; Wed, 12 Oct 2011 22:18:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753226Ab1JLUSn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Oct 2011 16:18:43 -0400
Received: from mail4.nrlssc.navy.mil ([128.160.11.9]:57563 "EHLO
	mail3.nrlssc.navy.mil" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752407Ab1JLUSm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Oct 2011 16:18:42 -0400
Received: by mail3.nrlssc.navy.mil id p9CKIatA008531; Wed, 12 Oct 2011 15:18:36 -0500
In-Reply-To: <7v8vorh3kg.fsf@alter.siamese.dyndns.org>
X-OriginalArrivalTime: 12 Oct 2011 20:18:34.0467 (UTC) FILETIME=[1E240B30:01CC891C]
X-Virus-Scanned: clamav-milter 0.97.2 at mail4
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183411>

On 10/11/2011 11:54 AM, Junio C Hamano wrote:
> Brandon Casey <casey@nrlssc.navy.mil> writes:
> 
>> ...  Currently, git builds the attr stack
>> based on the path supplied by the user, so we don't have to do anything
>> special (like use strcmp_icase) to handle the parts of that path that don't
>> match the filesystem with respect to case.  If git instead built the attr
>> stack by scanning the repository, then the paths in the origin field would
>> not necessarily match the paths supplied by the user.
> 
> I find this description somewhat misleading. "check-attr" at the plumbing
> level does take full path from the end user, but a common thing Git does
> is to ask the system to learn the prefix to the current directory with
> getcwd(3) append what fill_directory() enumerates as matching a pathspec
> given by the user with readdir(3) to the prefix to form the full path, and
> then feed that full path to git_check_attr().
> 
> Without anybody changing anything, we already do build the attr stack by
> "scanning the repository" in that case, no?

Well, kind of.  What I meant by "scanning the repository", was having
two separate mechanisms: one to build the attr stack, and one to scan it
to get the attributes.  Right now, the two operations are tied together
and the stack is built as needed, and it is built using the same path
string that the scan operation will use for checking for attributes.
So, the leading paths will match.

When I wrote that commit message, I really was only thinking about a
user-supplied path, but the focus should be on prepare_attr_stack().
The reason the leading paths to a .gitattributes file will necessarily
match is because the attr stack is built using the path supplied to
prepare_attr_stack(), and the same path string is used when scanning
the stack to check for attributes.  So each path that is supplied,
regardless of whether its case matches the case in the file system or
in the repository, will have an entry in the attr stack.

Maybe that last paragraph in the commit message should just be dropped.
I think the preceding paragraph explains the purpose of the tests, and
this last one doesn't really add any value.

Do you want me to resubmit or can you fix it up?  I ask not because I
am too lazy to do 'commit --amend' myself, but because you may prefer
to receive one less patch in your inbox if you can easily apply the
change yourself.

-Brandon
