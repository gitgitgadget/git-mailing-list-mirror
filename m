From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGIT PATCH 4/5] Add stack creation and initialisation support to lib.Stack
Date: Thu, 5 Jun 2008 13:42:03 +0100
Message-ID: <b0943d9e0806050542w663c64a8o93f81503eb811cf9@mail.gmail.com>
References: <20080604210655.32531.82580.stgit@localhost.localdomain>
	 <20080604211343.32531.41429.stgit@localhost.localdomain>
	 <20080605072822.GD23209@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Thu Jun 05 14:43:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4EoT-00045v-HC
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 14:43:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758549AbYFEMmg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Jun 2008 08:42:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758541AbYFEMmg
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 08:42:36 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:3157 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758289AbYFEMmf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Jun 2008 08:42:35 -0400
Received: by py-out-1112.google.com with SMTP id p76so462236pyb.10
        for <git@vger.kernel.org>; Thu, 05 Jun 2008 05:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=m8lF04TtTMbyIOgyW2TM/ZXrsDrLPNxqUF+Fma/UYvM=;
        b=WPcwJTURVuqcNiuC/lnvWvL2QiDgqY9gbfuvb5TmUkWGgPCrzxg4A29NYWgHxFIsfh
         Q2QTRszGHLWTHj0+RtQYrqzCFgxWNTJBv+L7Oojekr+mYJLNEDguv4jffXQBC/bPgXGs
         1ikpwsQp5xC3DF6ayA5qPl3bZA2mxLwHPIjQc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Mi7PvsM93uQ2hEJv9D/QDkOym4Iq2VPD1B7ECwrmM9DYRmsUfiSPvljReM6NNEucSo
         vvcHT/5LDXoO4lhAzf0J04ISDhqCiEbGRaItUx2rGnR9CVjAAI2rVr7GDo5C/qvlKrzG
         AeySkI2wIFyNNFv41qR5o37VndOh5X7uaCXUc=
Received: by 10.114.52.1 with SMTP id z1mr1414996waz.42.1212669723162;
        Thu, 05 Jun 2008 05:42:03 -0700 (PDT)
Received: by 10.114.171.16 with HTTP; Thu, 5 Jun 2008 05:42:03 -0700 (PDT)
In-Reply-To: <20080605072822.GD23209@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83915>

2008/6/5 Karl Hasselstr=F6m <kha@treskal.com>:
> On 2008-06-04 22:13:43 +0100, Catalin Marinas wrote:
>
>> This patch adds the create and initialise Stack classmethods to
>> handle the initialisation of StGIT patch series on a Git branch.
>
>> diff --git a/stgit/lib/stack.py b/stgit/lib/stack.py
>> index aca7a36..7375d41 100644
>> --- a/stgit/lib/stack.py
>> +++ b/stgit/lib/stack.py
>> @@ -3,6 +3,10 @@
>>  import os.path
>>  from stgit import exception, utils
>>  from stgit.lib import git, stackupgrade
>> +from stgit.config import config
>> +
>> +class StackException(exception.StgException):
>> +    """Exception raised by stack objects."""
>
> s/stack/L{Stack}/, perhaps?

I was more referring to objects in the lib.stack module, not only the
Stack class. Can this be expressed in any way with the epydoc format?

>> @@ -105,6 +109,14 @@ class PatchOrder(object):
>>      all =3D property(lambda self: self.applied + self.unapplied + s=
elf.hidden)
>>      all_visible =3D property(lambda self: self.applied + self.unapp=
lied)
>>
>> +    @staticmethod
>> +    def create(stackdir):
>> +        """Create the PatchOrder specific files
>> +        """
>> +        utils.create_empty_file(os.path.join(stackdir, 'applied'))
>> +        utils.create_empty_file(os.path.join(stackdir, 'unapplied')=
)
>> +        utils.create_empty_file(os.path.join(stackdir, 'hidden'))
>> +
>>  class Patches(object):
>>      """Creates L{Patch} objects. Makes sure there is only one such =
object
>>      per patch."""
>
> Wouldn't it be more consistent if the create function actually
> returned a PatchOrder object, like other creation functions?

It is a bit more complicated. PatchOrder requires a Stack object in
__init__ but the stack is not fully set up at this point.

> (You
> might even consider having these files auto-created whenever you
> instantiate a PatchOrder object and they don't yet exist.)

This is definitely a solution but at the moment we have to support the
old infrastructure which fails if the files aren't present. Once we
don't have any reference to the stgit.stack module, we can do this
more dynamically.

> Also, the creation function might instead live in the Stack class,
> since it owns the patch order.

See my reply to a previous patch with my view on ownership and
separation of functionality.

>> @@ -133,12 +145,14 @@ class Patches(object):
>>  class Stack(git.Branch):
>>      """Represents an StGit stack (that is, a git branch with some e=
xtra
>>      metadata)."""
>> +    __repo_subdir =3D 'patches'
>> +
>
> This needs to be in the previous patch, I think, since you use it
> there.

Yes.

>> +    def set_parents(self, remote, localbranch):
>> +        if not localbranch:
>> +            return
>> +        if remote:
>> +            self.set_parent_remote(remote)
>> +        self.set_parent_branch(localbranch)
>> +        config.set('branch.%s.stgit.parentbranch' % self._name, loc=
albranch)
>
> Hmm, I don't quite follow. Why is this a no-op if you give a false
> localbranch? And why is branch.<branchname>.stgit.parentbranch needed=
,
> when it's always the same as branch.<branchname>.merge? (Backwards
> compatibility? Would you mind making a comment about that, in that
> case?)

I don't fully follow it either :-). I just copied the code from
stgit.stack.Series but I don't make any use of it yet. I think it was
initially written by Yann Dirson for the "branch" command which I
haven't translated yet. I think branch.<branchname>.stgit.parentbranch
might be used by the current "pull" or "rebase" implementations. I'll
comment it out (but still keep it for now) and put a FIXME so that I
remember when converting the "branch" and "pull" commands.

>> +    @classmethod
>> +    def initialise(cls, repository, name =3D None):
>> +        """Initialise a Git branch to handle patch series."""
>> +        if not name:
>> +            name =3D repository.current_branch_name
>> +        # make sure that the corresponding Git branch exists
>> +        git.Branch(repository, name)
>> +
>> +        dir =3D os.path.join(repository.directory, cls.__repo_subdi=
r, name)
>> +        compat_dir =3D os.path.join(dir, 'patches')
>> +        if os.path.exists(dir):
>> +            raise StackException('%s: branch already initialized' %=
 name)
>> +
>> +        # create the stack directory and files
>> +        utils.create_dirs(dir)
>> +        utils.create_dirs(compat_dir)
>> +        PatchOrder.create(dir)
>> +        config.set(stackupgrade.format_version_key(name),
>> +                   str(stackupgrade.FORMAT_VERSION))
>> +
>> +        return repository.get_stack(name)
>
> This is not quite like the other "create" functions, since it just
> promotes a branch, without really creating it.

That was the intention. For creation, there is Stack.create which
handles the Git branch creation as well as the StGIT initialisation.

> What I'd really like to see here, I think, is something like this:
>
>  1. You get a Stack object from some stack.Repository method.
>
>  2. The Stack object works without having to be initialized, but the
>     operations that need initialization throw an exception.
>
>  3. The Stack object has an initialize() method -- just a normal
>     method, not a class method.

That was the original behaviour in stgit.stack.Series but if you
happen to try to access a patch or patchorder, you get some exception
on missing file form those objects rather than "stack not initialised"
from Stack.

> This will pave the way for automatic initialization -- just call
> self.initialize() instead of throwing an exception in step (2).

I'm not fully convinced with automatic initialisation. I have some
branches where I don't use StGIT but I might type a "stg series" by
mistake. The branch will be promoted to a stack but later Git doesn't
know about extra files in .git/patches and they aren't handled
(removed, renamed etc.). I'm more in favour of the explicit
initialisation.

>> +    @classmethod
>> +    def create(cls, repository, name,
>> +               create_at =3D None, parent_remote =3D None, parent_b=
ranch =3D None):
>> +        """Create and initialise a Git branch returning the L{Stack=
} object."""
>> +        git.Branch.create(repository, name, create_at =3D create_at=
)
>> +        stack =3D cls.initialise(repository, name)
>> +        stack.set_parents(parent_remote, parent_branch)
>> +        return stack
>
> Same point as with the other creation functions.
>
> And I'd appreciate some documentation on what the parameters mean --
> either here, or in the methods you call from here.

Yes, I'll add some description.

Thanks for your comments.

--=20
Catalin
