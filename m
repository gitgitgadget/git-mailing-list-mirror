From: Max Kirillov <max@max630.net>
Subject: Re: [PATCH v2 2/3] gitk: write only changed configuration variables
Date: Thu, 30 Oct 2014 23:43:57 +0200
Message-ID: <20141030214357.GA6484@wheezy.local>
References: <1410726959-20353-1-git-send-email-max@max630.net>
 <1410726959-20353-3-git-send-email-max@max630.net>
 <20141030095513.GE16472@iris.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Thu Oct 30 22:45:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XjxWf-0000qu-4G
	for gcvg-git-2@plane.gmane.org; Thu, 30 Oct 2014 22:45:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161307AbaJ3Vo5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2014 17:44:57 -0400
Received: from p3plsmtpa07-01.prod.phx3.secureserver.net ([173.201.192.230]:45202
	"EHLO p3plsmtpa07-01.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1161107AbaJ3Vo5 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Oct 2014 17:44:57 -0400
Received: from wheezy.local ([82.181.81.240])
	by p3plsmtpa07-01.prod.phx3.secureserver.net with 
	id 9Zko1p00N5B68XE01Zkuaj; Thu, 30 Oct 2014 14:44:55 -0700
Content-Disposition: inline
In-Reply-To: <20141030095513.GE16472@iris.ozlabs.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi.

On Thu, Oct 30, 2014 at 08:55:13PM +1100, Paul Mackerras wrote:
> It seems to me that we need the trace only for the
> non-array configuration variables; the array case is only
> for the view definitions, and I think we could just set
> the changed flag for a view explicitly in [newviewok].
> That would simplify things quite a bit.

I liked the idea to exploit that tcl can watch array element
uniformly with scalar variables. But I agree that the result
is a bit complicated. I will try to use the explicit flag and
see how it's going to look.

> On Sun, Sep 14, 2014 at 11:35:58PM +0300, Max Kirillov wrote:
> I'm also not convinced we need all the uses of upvar.  Why do we need
> to use upvar to rename viewname, viewfiles etc. to current_viewname,
> etc.?  If you're concerned about what might possibly be in the .gitk
> when you source it, perhaps doing the source inside a namespace would
> be a cleaner approach?

I have tried namespaces originally but failed with them.
Apparently when "set v .." runs in namespace and global v
exists, it modifies the global v rather than creates a new
variabe in a namespace. I don't remember all details now but
I could not find how to make it with namespaces. I should
say I had not known anything about tcl namespaces before
I started doing this but, so maybe I missed something.

-- 
Max

PS: the script which shows the namespace behavior:

> set a 1
> namespace eval ns1 {
>  set a 2
> }
> puts "a=$a"
> puts "ns1::a=$ns1::a"

Output is:
> a=2
> can't read "ns1::a": no such variable
>    while executing
> "puts "ns1::a=$ns1::a""
