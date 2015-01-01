From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: saving "git push --signed" certificate blobs
Date: Thu, 01 Jan 2015 07:29:14 +0530
Message-ID: <54A4A9F2.6020601@gmail.com>
References: <54A10ED1.9020704@gmail.com> <54A22586.70001@gmail.com> <xmqqiogtrptu.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070705060603090108030609"
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 01 03:00:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y6V3y-0005Ln-Ua
	for gcvg-git-2@plane.gmane.org; Thu, 01 Jan 2015 03:00:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751500AbbAAB7V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Dec 2014 20:59:21 -0500
Received: from mail-pd0-f176.google.com ([209.85.192.176]:65287 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751208AbbAAB7U (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Dec 2014 20:59:20 -0500
Received: by mail-pd0-f176.google.com with SMTP id r10so21722559pdi.21
        for <git@vger.kernel.org>; Wed, 31 Dec 2014 17:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type;
        bh=0/Tbt7hJenvlj/zooLkNzQ+jQu64nGbR0SIgctg5P7I=;
        b=C0ApwwUNFJA99D8+ceBBZfDqa1okj7bKMOILJPnpJfLhussQbi7Fg4mOYX4MZTpSo8
         nvez/d+x2HVNKRK5BXNp6l9d9Xl286Bd3ifL7AeBtwkt4R/xKlqTqFUULMgIat/RIwyQ
         CckZgd1tdzGsJD6e4ovAF1E4dugBBD3XyzZQWaK/3vki5zoiZfBasuy8ngNYesOhv3ts
         1vniXSehEdpRbN7ZkQrZrrfM7fDY0DX7f6qQr9aph8qYbzmQgxcUqzKFGtes1hMqAV7U
         jpOKnaimbkx3khY65a3vlI3sQSysIEHDSSQNz3bW7VGXrlCAxTyfBkHiQGLdU4F9U8W2
         lO1A==
X-Received: by 10.66.65.75 with SMTP id v11mr108340999pas.81.1420077560112;
        Wed, 31 Dec 2014 17:59:20 -0800 (PST)
Received: from sita-lt.atc.tcs.com ([117.195.169.235])
        by mx.google.com with ESMTPSA id bl10sm42670984pac.23.2014.12.31.17.59.16
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Dec 2014 17:59:18 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
In-Reply-To: <xmqqiogtrptu.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261970>

This is a multi-part message in MIME format.
--------------070705060603090108030609
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit

On 12/30/2014 11:18 PM, Junio C Hamano wrote:
> Sitaram Chamarty <sitaramc@gmail.com> writes:
> 
>> Just wanted to say there's a little script at [1] that saves the certificate
>> blobs generated on the server side by "git push --signed".
>>
>> Quoting from the source:
>>
>> # Collects the cert blob on push and saves it, then, if a certain number of
>> # signed pushes have been seen, processes all the "saved" blobs in one go,
>> # adding them to the special ref 'refs/push-certs'.  This is done in a way
>> # that allows searching for all the certs pertaining to one specific branch
>> # (thanks to Junio Hamano for this idea plus general brainstorming).
>>
>> Note that although I posted it in the gitolite ML, this has very little to do
>> with gitolite.  Any git server can use it, with only one very minor change [2]
>> needed.
>>
>> sitaram
>>
>> [1]: https://groups.google.com/forum/#!topic/gitolite/7cSrU6JorEY
>>
>> [2]: Either set the GL_OPTIONS_GPC_PENDING environment variable by reading its
>> value from 'git config', or replace the only line that uses that variable, with
>> some other "test".
> 
> Nicely done.
> 
> We'd need to give you a tool to make it easy to create a "validated
> chain of certificates" out of
> 
>     $ git log refs/push-certs -- refs/heads/master
> 
> to make the history this script creates truly useful, but I think it
> is a very good start.
> 
> I can see that you tried to make the log output "human readable" by
> reformatting $cf, I am not sure if it gives us much value.  I would
> have expected that you would just use the blob contents for the log
> message as-is, so that
> 
>     $ git log --pretty=raw refs/push-certs -- refs/heads/master |
>       validate-cert-chain
> 
> can just work on blobs (shown in the "log" output) without having to
> extract the blobs by doing something like
> 
>     $ git rev-list refs/push-certs -- refs/heads/master |
>       while read commit
>       do
> 		git cat-file blob $commit:refs/heads/master |
>                 validate-cert
>       done

I see what you mean.  And it looks like using "--format=%B also works
pretty well.  Will fix.

> By the way, you seem to like "cat" too much, though.  You don't have
> to cat a single file into a pipeline.

Gee I hope Randal Schwartz is not on this list :)

Anyway the previous fix also removes most of them.

I'm attaching the current version so non-gitolite users can find it
without having to go to the gitolite repo.  For gitolite users, it's
somewhere in "contrib/" in the source tree.

sitaram

> Thanks.
> 


--------------070705060603090108030609
Content-Type: text/plain; charset=UTF-8;
 name="save-push-signatures"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="save-push-signatures"

#!/bin/sh

# ----------------------------------------------------------------------
# post-receive hook to adopt push certs into 'refs/push-certs'

# Collects the cert blob on push and saves it, then, if a certain number of
# signed pushes have been seen, processes all the "saved" blobs in one go,
# adding them to the special ref 'refs/push-certs'.  This is done in a way
# that allows searching for all the certs pertaining to one specific branch
# (thanks to Junio Hamano for this idea plus general brainstorming).

# The "collection" happens only if $GIT_PUSH_CERT_NONCE_STATUS = OK; again,
# thanks to Junio for pointing this out; see [1]
#
# [1]: https://groups.google.com/forum/#!topic/gitolite/7cSrU6JorEY

# WARNINGS:
#   Does not check that GIT_PUSH_CERT_STATUS = "G".  If you want to check that
#   and FAIL the push, you'll have to write a simple pre-receive hook
#   (post-receive is not the place for that; see 'man githooks').
#
#   Gitolite users: failing the hook cannot be done as a VREF because git does
#   not set those environment variables in the update hook.  You'll have to
#   write a trivial pre-receive hook and add that in.

# Relevant gitolite doc links:
#   repo-specific environment variables
#       http://gitolite.com/gitolite/dev-notes.html#rsev
#   repo-specific hooks
#       http://gitolite.com/gitolite/non-core.html#rsh
#       http://gitolite.com/gitolite/cookbook.html#v3.6-variation-repo-specific-hooks

# Environment:
#   GIT_PUSH_CERT_NONCE_STATUS should be "OK" (as mentioned above)
#
#   GL_OPTIONS_GPC_PENDING (optional; defaults to 1).  This is the number of
#   git push certs that should be waiting in order to trigger the post
#   processing.  You can set it within gitolite like so:
#
#       repo foo bar    # or maybe just 'repo @all'
#           option ENV.GPC_PENDING = 5

# Setup:
#   Set up this code as a post-receive hook for whatever repos you need to.
#   Then arrange to have the environment variable GL_OPTION_GPC_PENDING set to
#   some number, as shown above.  (This is only required if you need it to be
#   greater than 1.)  It could of course be different for different repos.
#   Also see "Invocation" section below.

# Invocation:
#   Normally via git (see 'man githooks'), once it is setup as a post-receive
#   hook.
#
#   However, if you set the "pending" limit high, and want to periodically
#   "clean up" pending certs without necessarily waiting for the counter to
#   trip, do the following (untested):
#
#       RB=$(gitolite query-rc GL_REPO_BASE)
#       for r in $(gitolite list-phy-repos)
#       do
#           cd $RB/$repo.git
#           unset GL_OPTIONS_GPC_PENDING    # if it is set higher up
#           hooks/post-receive post_process
#       done
#
#   That will take care of it.

# Using without gitolite:
#   Just set GL_OPTIONS_GPC_PENDING within the script (maybe read it from git
#   config).  Everything else is independent of gitolite.

# ----------------------------------------------------------------------
# make it work on BSD also (but NOT YET TESTED on FreeBSD!)
uname_s=`uname -s`
if [ "$uname_s" = "Linux" ]
then
    _lock() { flock "$@"; }
else
    _lock() { lockf -k "$@"; }
    # I'm assuming other BSDs also have this; I only have FreeBSD.
fi

# ----------------------------------------------------------------------
# standard stuff
die() { echo "$@" >&2; exit 1; }
warn() { echo "$@" >&2; }

# ----------------------------------------------------------------------
# if there are no arguments, we're running as a "post-receive" hook
if [ -z "$1" ]
then
    # ignore if it may be a replay attack
    [ "$GIT_PUSH_CERT_NONCE_STATUS" = "OK" ] || exit 1
    # I don't think "exit 1" does anything in a post-receive anyway, so that's
    # just a symbolic gesture!

    # note the lock file used
    _lock .gpc.lock $0 cat_blob

    # if you want to initiate the post-processing ONLY from outside (for
    # example via cron), comment out the next line.
    exec $0 post_process
fi

# ----------------------------------------------------------------------
# the 'post_process' part; see "Invocation" section in the doc at the top
if [ "$1" = "post_process" ]
then
    # this is the same lock file as above
    _lock .gpc.lock $0 count_and_rotate $$

    [ -d git-push-certs.$$ ] || exit 0

    # but this is a different one
    _lock .gpc.ref.lock $0 update_ref $$

    exit 0
fi

# ----------------------------------------------------------------------
# other values for "$1" are internal use only

if [ "$1" = "cat_blob" ]
then
    mkdir -p git-push-certs
    git cat-file blob $GIT_PUSH_CERT > git-push-certs/$GIT_PUSH_CERT
    echo $GIT_PUSH_CERT >> git-push-certs/.blob.list
fi

if [ "$1" = "count_and_rotate" ]
then
    count=$(ls git-push-certs | wc -l)
    if test $count -ge ${GL_OPTIONS_GPC_PENDING:-1}
    then
        # rotate the directory
        mv git-push-certs git-push-certs.$2
    fi
fi

if [ "$1" = "update_ref" ]
then
    # use a different index file for all this
    GIT_INDEX_FILE=push_certs_index; export GIT_INDEX_FILE

    # prepare the special ref to receive commits
    PUSH_CERTS=refs/push-certs
    if git rev-parse -q --verify $PUSH_CERTS >/dev/null
    then
        git read-tree $PUSH_CERTS
    else
        git read-tree --empty
        T=$(git write-tree)
        C=$(echo 'start' | git commit-tree $T)
        git update-ref $PUSH_CERTS $C
    fi

    # for each cert blob...
    for b in `cat git-push-certs.$2/.blob.list`
    do
        cf=git-push-certs.$2/$b

        # it's highly unlikely that the blob got GC-ed already but write it
        # back anyway, just in case
        B=$(git hash-object -w $cf)

        # bit of a sanity check
        [ "$B" = "$b" ] || warn "this should not happen: $B is not equal to $b"

        # for each ref described within the cert, update the index
        for ref in `cat $cf | egrep '^[a-f0-9]+ [a-f0-9]+ refs/' | cut -f3 -d' '`
        do
            git update-index --add --cacheinfo 100644,$b,$ref
            # we're using the ref name as a "fake" filename, so people can,
            # for example, 'git log refs/push-certs -- refs/heads/master', to
            # see all the push certs pertaining to the master branch.  This
            # idea came from Junio Hamano, the git maintanier (I certainly
            # don't deal with git plumbing enough to have thought of it!)
        done

        T=$(git write-tree)
        C=$( git commit-tree -p $PUSH_CERTS $T < $cf )
        git update-ref $PUSH_CERTS $C

        rm -f $cf
    done
    rm -f git-push-certs.$2/.blob.list
    rmdir git-push-certs.$2
fi

--------------070705060603090108030609--
