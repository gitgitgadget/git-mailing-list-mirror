From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Feature request: separate namespace for remote tags
Date: Mon, 22 Feb 2010 13:22:57 -0500
Message-ID: <32541b131002221022h57c6bf05mdeb8d27cdbbd1f54@mail.gmail.com>
References: <4B827C48.9060601@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Avi Kivity <avi@redhat.com>
X-From: git-owner@vger.kernel.org Mon Feb 22 19:23:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjcwI-0004uY-8i
	for gcvg-git-2@lo.gmane.org; Mon, 22 Feb 2010 19:23:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753810Ab0BVSXU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Feb 2010 13:23:20 -0500
Received: from mail-yw0-f197.google.com ([209.85.211.197]:42428 "EHLO
	mail-yw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753233Ab0BVSXR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Feb 2010 13:23:17 -0500
Received: by ywh35 with SMTP id 35so1270863ywh.4
        for <git@vger.kernel.org>; Mon, 22 Feb 2010 10:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=mynHnH0Qaz9Rn8w4MBaOJH3zuCM4RQWxXDd5iQykZQM=;
        b=eLT4/ii2QpKzwd63og3NWQHJDrOeUbPdpZwz90gE4pYTrhyD30SLGxCeJEFhSoSJ/O
         Qqd2lej9yYnCqAx4vE9ovLP+awqNQRntLiVk3I4DKd/F4fLieKXOC3zOy1rolWlNWIKz
         p/8ilA1HEQX+R6rGURn/eNNQ8d8YgVZ/m5/Ic=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=sL5dWYi07ezMj3utcRk4Y67Q05j7f1nZmqZGrPYhUGz+f0LxT0FpiG7b1+u1C1uHnT
         nOdIcOoIL0tIEi58gn07xdMYeZUqPfr5HQQx+3VcHNH7ek4EnalhZ6Huyx1uxEYhQCpM
         7bOO9eYwUARESNbalU9wZT14WCiUyiCYTm+Fg=
Received: by 10.150.174.35 with SMTP id w35mr1546933ybe.8.1266862997147; Mon, 
	22 Feb 2010 10:23:17 -0800 (PST)
In-Reply-To: <4B827C48.9060601@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140705>

On Mon, Feb 22, 2010 at 7:44 AM, Avi Kivity <avi@redhat.com> wrote:
> Currently, 'git remote add foo ...' will allocate a separate namespac=
e for
> foo branches (refs/remotes/foo/*) but will store foo tags in the main=
 tag
> namespace (refs/tags/*). =A0This leads to several problems:
>
> - the main tag namespace becomes polluted with zillions of tags
> - if the tags from a remote conflict with a local (or perhaps another
> remote) tag, information is lost
> - 'git remote rm' will not delete the remote tags, and so 'git gc' wi=
ll not
> recover much of the space used by the remote

I've sometimes wished for such a feature myself.  When merging things
using git-subtree, for example, you can easily end up importing
"v1.2.3" type tags from two different projects and causing yourself
total confusion.

However, just dividing the tags into namespaces removes one of the
nicest features of tags, which is that they uniquely identify a
particular revision across all repositories.  The whole point is that
ap/v1.2.3 isn't ever supposed to differ from origin/v1.2.3.

One option would be to split the tags into namespaces, but then
automatically search all namespaces when looking for a particular tag.
 Then when you drop a particular remote, you'd lose all its tags, but
if you *don't* drop that remote, things look like they always have.

Have fun,

Avery
