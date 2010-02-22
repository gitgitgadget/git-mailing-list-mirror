From: Avi Kivity <avi@redhat.com>
Subject: Re: Feature request: separate namespace for remote tags
Date: Mon, 22 Feb 2010 20:35:04 +0200
Message-ID: <4B82CE58.8060902@redhat.com>
References: <4B827C48.9060601@redhat.com> <32541b131002221022h57c6bf05mdeb8d27cdbbd1f54@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 22 19:35:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Njd7m-00012k-DY
	for gcvg-git-2@lo.gmane.org; Mon, 22 Feb 2010 19:35:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753039Ab0BVSfM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2010 13:35:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:8647 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752522Ab0BVSfL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2010 13:35:11 -0500
Received: from int-mx03.intmail.prod.int.phx2.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.16])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id o1MIZ93G001229
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Mon, 22 Feb 2010 13:35:09 -0500
Received: from firebolt.argo.co.il (vpn-6-49.tlv.redhat.com [10.35.6.49])
	by int-mx03.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id o1MIZ5O8008617;
	Mon, 22 Feb 2010 13:35:06 -0500
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.7) Gecko/20100120 Fedora/3.0.1-1.fc12 Thunderbird/3.0.1
In-Reply-To: <32541b131002221022h57c6bf05mdeb8d27cdbbd1f54@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.16
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140707>

On 02/22/2010 08:22 PM, Avery Pennarun wrote:
> On Mon, Feb 22, 2010 at 7:44 AM, Avi Kivity<avi@redhat.com>  wrote:
>    
>> Currently, 'git remote add foo ...' will allocate a separate namespace for
>> foo branches (refs/remotes/foo/*) but will store foo tags in the main tag
>> namespace (refs/tags/*).  This leads to several problems:
>>
>> - the main tag namespace becomes polluted with zillions of tags
>> - if the tags from a remote conflict with a local (or perhaps another
>> remote) tag, information is lost
>> - 'git remote rm' will not delete the remote tags, and so 'git gc' will not
>> recover much of the space used by the remote
>>      
> I've sometimes wished for such a feature myself.  When merging things
> using git-subtree, for example, you can easily end up importing
> "v1.2.3" type tags from two different projects and causing yourself
> total confusion.
>
> However, just dividing the tags into namespaces removes one of the
> nicest features of tags, which is that they uniquely identify a
> particular revision across all repositories.  The whole point is that
> ap/v1.2.3 isn't ever supposed to differ from origin/v1.2.3.
>    

That's why I suggested not creating ap/v1.2.3 if it matches 
refs/tags/v1.2.3 (a clone would default to using regs/tags, not 
refs/remote-tags/origin).  If they don't match, at least you don't lost 
information.

> One option would be to split the tags into namespaces, but then
> automatically search all namespaces when looking for a particular tag.
>   Then when you drop a particular remote, you'd lose all its tags, but
> if you *don't* drop that remote, things look like they always have.
>    

Yes.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.
