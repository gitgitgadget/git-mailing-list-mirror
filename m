From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Proposed function path_in_directory() [was: Re: [PATCH v2 8/9] longest_ancestor_length():
 resolve symlinks before comparing paths]
Date: Sat, 06 Oct 2012 10:04:41 +0200
Message-ID: <506FE619.1020608@alum.mit.edu>
References: <1348899362-4057-1-git-send-email-mhagger@alum.mit.edu> <1348899362-4057-9-git-send-email-mhagger@alum.mit.edu> <7vd314gcti.fsf@alter.siamese.dyndns.org> <50692150.8080504@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Lea Wiemann <lewiemann@gmail.com>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 06 10:05:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TKPNu-00018t-Bh
	for gcvg-git-2@plane.gmane.org; Sat, 06 Oct 2012 10:05:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753229Ab2JFIEu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Oct 2012 04:04:50 -0400
Received: from ALUM-MAILSEC-SCANNER-4.MIT.EDU ([18.7.68.15]:56805 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752089Ab2JFIEp (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Oct 2012 04:04:45 -0400
X-AuditID: 1207440f-b7fde6d00000095c-d3-506fe61cf603
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 69.FE.02396.C16EF605; Sat,  6 Oct 2012 04:04:44 -0400 (EDT)
Received: from [192.168.69.140] (p57A252B8.dip.t-dialin.net [87.162.82.184])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q9684fFq021068
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 6 Oct 2012 04:04:42 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120827 Thunderbird/15.0
In-Reply-To: <50692150.8080504@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLKsWRmVeSWpSXmKPExsUixO6iqCvzLD/AYOITfYuuK91MFg29V5gt
	nsy9y2xx9JSFxfp3V5kdWD12zrrL7vHwVRe7x8VLyh6fN8kFsERx2yQllpQFZ6bn6dslcGfM
	2dHGXnBbvGL1kcIGxgtCXYycHBICJhJbT/5ihrDFJC7cW8/WxcjFISRwmVFi59WzjBDOaSaJ
	Uz9fglXxCmhLdOw5yQhiswioSmy7OgMsziagK7Gop5kJxBYVCJGYcXkyVL2gxMmZT1hAbBEB
	NYmJbYdYQIYyC7QzSnT9XMgE4ggL9DJK3Di2kB1i3VFGiW2nJoOt4BTQkZi34ROYzQxkv+t7
	wAxhy0tsfzuHeQKjwCwkW2YhKZuFpGwBI/MqRrnEnNJc3dzEzJzi1GTd4uTEvLzUIl0TvdzM
	Er3UlNJNjJDg5t/B2LVe5hCjAAejEg/vRZX8ACHWxLLiytxDjJIcTEqivA5PgEJ8SfkplRmJ
	xRnxRaU5qcWHGCU4mJVEeK2CgHK8KYmVValF+TApaQ4WJXFe9SXqfkIC6YklqdmpqQWpRTBZ
	GQ4OJQne7yBDBYtS01Mr0jJzShDSTBycIMO5pESKU/NSUosSS0sy4kHxGl8MjFiQFA/Q3vkg
	7bzFBYm5QFGI1lOMuhwfG+c9ZBRiycvPS5US5+0HKRIAKcoozYNbAUtlrxjFgT4W5n0PUsUD
	TINwk14BLWECWlIcmQuypCQRISXVwOh6/4l+ecN818k3vuyqmbF5UzivsxpfTGLWTIOjsVuS
	ZibNXHrqpEy2W+CE8CsPO6XssnakXLuYGpel9OBnOs8XyVMxOi06h6/eyt7LfUhp 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207138>

On 10/01/2012 06:51 AM, Michael Haggerty wrote:
> I think I would advocate that the prefix has to match the front of the
> path exactly (including any trailing slashes) and either
> 
>     strlen(prefix) == 0
>     or the prefix ended with a '/'
>     or the prefix and path are identical
>     or the character in path following the matching part is a '/'
> 
> This would allow the "is path its own prefix" policy to be decided by
> the caller by either including or omitting a trailing slash on the
> prefix argument.

Thinking about this more, I don't think it will work.  As usual, the
special cases around "/" and "//" make things awkward.  I think it is
necessary to have a separate argument to specify whether "path is its
own prefix".

So I am trying to decide how a function path_in_directory() should work,
and would like to get some feedback, especially on the following two points:

1. How should "//" be handled?  I don't really have experience with the
peculiar paths that start with "//", so I'm not sure how they should be
handled (or even if the handling needs to be platform-dependent).  My
working hypothesis is that the inputs should be normalized by the
caller, so if the caller wants "//" to be treated as equivalent to "/"
then the caller should normalize them *before* calling this function.
Conversely, if the caller passes "//" to the function, that implies that
"//" is distinct from "/" and "//" is considered a proper subdirectory
of "/".  See the cases marked with "??????" below.

2. Does there need to be any special related to DOS paths?

> /*
>  * Return true iff path is within dir.  The comparison is textual,
>  * meaning that path and dir should be normalized and either both be
>  * absolute or both be relative to the same directory.  If path and
>  * dir represent the *same* path, then return true iff allow_equal is
>  * true.  Single trailing slashes on either path or dir are ignored,
>  * (except for the special case "//"); i.e., "a/b" and "a/b/" are
>  * treated equivalently, as are "" and "/".  Examples (* means "don't
>  * care"):
>  *
>  * - path_in_directory("a/b", "a", *) -> true
>  * - path_in_directory("a", "a/b", *) -> false
>  * - path_in_directory("ab", "a", *) -> false
>  * - path_in_directory("a/b", "a/b", 0) -> false
>  *   (same if either argument is replaced with "a/b/")
>  * - path_in_directory("a/b", "a/b", 1) -> true
>  *   (same if either argument is replaced with "a/b/")
>  * - path_in_directory(*, "/", 1) -> true
>  * - path_in_directory("/", "/", 0) -> false
>  * - path_in_directory("//", "/", 0) -> true    ??????
>  * - path_in_directory("//", "/", 1) -> true
>  * - path_in_directory("/", "//", 0) -> false
>  * - path_in_directory("/", "//", 1) -> false   ??????
>  * - path_in_directory("/a/b", "//", *) -> false
>  */
> int path_in_directory(const char *path, const char *dir, int allow_equal);

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
