From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: RFC/Pull Request: Refs db backend
Date: Tue, 23 Jun 2015 23:27:50 +0200
Message-ID: <5589CF56.2010309@alum.mit.edu>
References: <1435020656.28466.8.camel@twopensource.com>	 <55898073.4010105@alum.mit.edu> <1435089205.28466.56.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: git mailing list <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Tue Jun 23 23:28:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7Vjo-0002eO-J2
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jun 2015 23:28:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932133AbbFWV2H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jun 2015 17:28:07 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:60549 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754901AbbFWV2F (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Jun 2015 17:28:05 -0400
X-AuditID: 12074411-f797e6d000007df3-dd-5589cf5719b7
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 3B.D7.32243.75FC9855; Tue, 23 Jun 2015 17:27:51 -0400 (EDT)
Received: from [192.168.69.130] (p4FC972ED.dip0.t-ipconnect.de [79.201.114.237])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t5NLRo17021780
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 23 Jun 2015 17:27:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.7.0
In-Reply-To: <1435089205.28466.56.camel@twopensource.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnleLIzCtJLcpLzFFi42IRYndR1A0/3xlq8OWvicX8TScYLbqudDM5
	MHkseH6f3ePzJrkApihum6TEkrLgzPQ8fbsE7oxDPduYC366VyyY8pq1gfGjZRcjJ4eEgInE
	7cM3WSFsMYkL99azgdhCApcZJbpuJ3cxcgHZF5gkZrx5xgiS4BXQlrjyaQ+YzSKgKrGzdy6Y
	zSagK7Gop5mpi5GDQ1QgSOL1y1yIckGJkzOfsIDYIkCts4/0gO1iFtCSmPt4L9guYQE9iYfn
	17ND7GpllDh7YRNYglPAUmLdu4fsEA3qEn/mXWKGsOUlmrfOZp7AKDALyY5ZSMpmISlbwMi8
	ilEuMac0Vzc3MTOnODVZtzg5MS8vtUjXVC83s0QvNaV0EyMkUAV3MM44KXeIUYCDUYmH98TU
	jlAh1sSy4srcQ4ySHExKorwnTnSGCvEl5adUZiQWZ8QXleakFh9ilOBgVhLhFToAlONNSays
	Si3Kh0lJc7AoifPyLVH3ExJITyxJzU5NLUgtgsnKcHAoSfC6nANqFCxKTU+tSMvMKUFIM3Fw
	ggznkhIpTs1LSS1KLC3JiAdFanwxMFZBUjxAe5VB2nmLCxJzgaIQracYFaXEeb+fBUoIgCQy
	SvPgxsLSzytGcaAvhXk/g1TxAFMXXPcroMFMQIN3TQUbXJKIkJJqYNRS+rZAJbNHRUvwl0ZO
	/T/dby0Ji7nLZz0/zvVvj8qEJ6ffZk8WXFYj7eI8lYN/zfnV2atF711JtNg+80rjtuSof5pN
	Ce9czz1aIPBPkCNMUFDy/m1HfnO7DdMbPoXMKtptOOX7o5U3OEW4sk4aVk/+Ns/h 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272519>

On 06/23/2015 09:53 PM, David Turner wrote:
> On Tue, 2015-06-23 at 17:51 +0200, Michael Haggerty wrote:
> [...]
>> * I don't like the fact that you have replaced `struct ref_transaction
>> *` with `void *` in the public interface. On a practical level, I like
>> the bit of type-safety that comes with the more specific declaration.
>> But on a more abstract level, I think that the concept of a transaction
>> could be useful across backends, for example in utility functions that
>> verify that a proposed set of updates are internally consistent. I would
>> rather see either
>>
>>   * backends "extend" a basic `struct ref_transaction` to suit their
>> needs, and upcast/downcast pointers at the module boundary, or
>>
>>   * `struct ref_transaction` itself gets a `void *` member that backends
>> can use for whatever purposes they want.
> 
> There are no common fields between refs-be-file transactions and
> refs-be-lmdb transactions.  I don't see much gain from adding an empty
> ref_transaction that backends could extend, since we would have to
> explicitly upcast/downcast all over the place.

If you ask me, it would be better to do a bunch of up/downcasts within
the single module (via two helper functions that could even do
consistency checks) than have no help from the compiler in preventing
people from passing unrelated pointer types into the `void *transaction`
argument. Plus the `struct ref_transaction *` variables scattered
throughout the code are a lot more self-explanatory than `void *`.

>> * Regarding MERGE_HEAD: you take the point of view that it must continue
>> to be stored as a file. And yet it must also behave somewhat like a
>> reference; for example, `git rev-parse MERGE_HEAD` works today.
>> MERGE_HEAD is also used for reachability, right?
>>
>> Another point of view is that MERGE_HEAD is a plain old boring
>> reference, but there is some other metadata related to it that the refs
>> backend has to store. The file-based backend would have special-case
>> code to read the additional data from the tail of the loose refs file
>> (and be sure to write the metadata when writing the reference), but
>> other backends could store the reference with the rest but do their own
>> thing with the metadata. So I guess I'm wondering whether the refs API
>> needs a MERGE_HEAD-specific way to read and write MERGE_HEAD along with
>> its metadata.
> 
> You are probably right that this is a good idea.
> 
>> * Don't the same considerations that apply to MERGE_HEAD also apply to
>> FETCH_HEAD?
> 
> All of the tests pass without any special handling of FETCH_HEAD.

That's odd. From git-fetch.txt:

    The names of refs that are fetched, together with the object names
    they point at, are written to `.git/FETCH_HEAD`.  This information
    may be used by scripts or other git commands, such as
    linkgit:git-pull[1].

It seems like the test suite is reading FETCH_HEAD via the refs API in a
couple of places. I don't understand why these don't fail when LMDB is
being used...

>> * I'm showing my ignorance of LMDB, but I don't see where the LMDB
>> backend initializes its database during `git init-db`. Is that what
>> `init_env()` does? But it looks like `init_env()` is called on every git
>> invocation (via `git_config_early()`). Puzzled.
> 
> There is no need to explicitly create the database (other than with
> mkdir); init_env does everything for you.

OK.

>> * Rehash of the last two points: I expected one backend function that is
>> used to initialize the refs backend when a new repository is created
>> (e.g., in `git init`). The file-based backend would use this function to
>> create the `refs`, `refs/heads`, and `refs/tags` directories. I expected
>> a second function that is called once every time git runs in an existing
>> repository (this one might, for example, open a database connection).
>> And maybe even a third one that closes down the database connection
>> before git exits. Would you please explain how this actually works?
> 
> LMDB doesn't really have the concept of a "connection".  It's basically
> just a couple of files that communicate using shared memory (and maybe
> some other locking that I haven't paid attention to).  There is the
> concept of a "transaction", which is the unit of concurrency (each
> thread may only have one open transaction).  Transactions are either
> read-only or read-write, and there can only be one read-write
> transaction open at a time (across the entire system).  Read-only
> transactions take a snapshot of the DB state at transaction start time.
> This combination of features means that we need to be a bit clever about
> read-only transactions; if a read-write transaction occurs in a separate
> process, we need to restart any read-only transactions to pick up its
> changes.

If you are thinking about an *unrelated* separate process, then Git's
philosophy is that if our process is reading *some* valid state of the
references, it's all good even if that state is not quite the newest.
After all, who's to say whether our process ran before or after the
other process? As long as each process sees self-consistent views of the
world as it existed at some recent time, we're satisfied.

To be sure, we even fail at that unambitious goal, because loose
reference reads are not atomic. It is possible that we read some
references in the state they had before the other process ran, and
others in the state they had after the other process was finished. This
can get ugly if, for example, the other process renamed a reference,
because we might not see the reference under either its old *or* its new
name. We might therefore conclude that the objects reachable from that
reference are dangling and garbage-collect them.

If the other process is one that we started ourselves, then that is a
different situation and we would want, for example, to invalidate our
reference cache after the other process is done.

One of the long-standing hopes of a DB-backed reference backend would be
to improve this situation--allowing atomic writes *and* reads.

> [...]
> 
>> * You explain in the docstring to `lmdb_transaction_begin_flags()` that
>> it is dangerous to call a callback function while a write transaction is
>> open if the callback function might want to initiate another write
>> transaction. This would obviously also apply to running hooks.
> 
> I carefully limit the scope of write transactions to avoid problems like
> this.
> 
>>  This is a
>> limitation of LMDB because writers block each other. I can't think of
>> anyplace that this would be a problem in our codebase. But if it were,
>> it seems to me that you could take an approach like the file-based
>> backend, which collects the transaction in a `ref_transaction` data
>> structure, and executes the entire transaction within a single call to
>> `ref_transaction_commit()`. This approach would prevent callers outside
>> of the refs module from ever bumping against this limitation.
> 
> The file-based backend does per-ref locking early, and then applies the
> transactions. Here, taking the write transaction is how the lmdb backend
> does locking.  So the situations are not quite the same.  But I think
> keeping the scope of transactions small is the best plan.

The file-based backend locks the references early *within
ref_transaction_commit()*, not as the transaction is being built up
using ref_transaction_update() etc. This is a big difference, because
code anywhere can call

    ref_transaction_begin(...);
    ANYTHING
    ref_transaction_update(...);
    ANYTHING
    ref_transaction_commit(...);

The only way to be sure that ANYTHING can't create a deadlock with the
open transaction (for example by calling a hook script that runs a git
command) is to audit all of that code now and in the future. Whereas the
file-based backend doesn't do anything that is externally observable or
deadlocky except within the single ref_transaction_commit() function
call, so only that one function has to be audited for actions that could
cause a deadlock.

> [...]
>> Let me know if you need any help rebasing your work onto my recent
>> changes. It would probably work best if you break your patch series into
>> smaller pieces to make them easier for the mailing list to digest. For
>> example, the first installment could be the patches that make sense even
>> independent of the plan to add support for multiple backends: the first
>> two patches, plus the ones related to CHERRY_PICK_HEAD and its cousins,
>> the abstraction of the reflog functions, and the `git reflog create` and
>> `git reflog exists` subcommands.
> 
> I would love some help rebasing. I'll break out the patches you suggest
> and send them to the list, then create a new branch with the rest of the
> changes.  Would that be a good place for you to start?

That sounds like a good next step, maybe after waiting a day or so to
see if there are any fundamental objections to what you have done so far.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
