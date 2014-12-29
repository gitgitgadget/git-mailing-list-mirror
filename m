From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 6/7] push.c: add an --atomic argument
Date: Mon, 29 Dec 2014 10:14:52 -0800
Message-ID: <CAGZ79kY7T20T8Z0SKjv20W0fiK7LO=EKj93XU8O13Nb6bLLsOg@mail.gmail.com>
References: <1419017941-7090-1-git-send-email-sbeller@google.com>
	<1419017941-7090-7-git-send-email-sbeller@google.com>
	<549D0B78.402@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: ronnie sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Ronnie Sahlberg <sahlberg@google.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Dec 29 19:15:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y5eqI-00031D-Gh
	for gcvg-git-2@plane.gmane.org; Mon, 29 Dec 2014 19:14:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751687AbaL2SOy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Dec 2014 13:14:54 -0500
Received: from mail-ie0-f182.google.com ([209.85.223.182]:65330 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751315AbaL2SOx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Dec 2014 13:14:53 -0500
Received: by mail-ie0-f182.google.com with SMTP id x19so12512302ier.27
        for <git@vger.kernel.org>; Mon, 29 Dec 2014 10:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=kY5HjZPVGCeBXwzObvq9m261Tt0+TlpRxI4esZV+hZk=;
        b=fCeRH5YaDG0IEIRNviZm1PNQbyc3iPia3gx18Z16Es9rOzIiu2wCGfhw49g1IIGwAi
         fSpcCNPFzhDXZk0U4wdOkIvqSLbNKCBVB2cnTjpuRR1NWTvUzKSOWAwg1K5FLqO/65Rt
         9/at2TchjiOdmutvujewc8JYwkLfaWnXjcdpA+yaw6RhhvHfRbio6nsrNBLQ0PAxXFnY
         Ujbd8KJJV+NTsAGyk+8Cik6H3G1NO2U4S/tBmJeO+uIljTpA8g4pRfLDnenIaJ5YV7vm
         diUBDbP1LqsCrilXv34LVWtrqgHy5qISKQuVQIxDueuJEGz7CEf31w+giZaMmgYX9zbE
         En0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=kY5HjZPVGCeBXwzObvq9m261Tt0+TlpRxI4esZV+hZk=;
        b=b/Of+0ArQhx4ZsEJTHIUrp4cTlItjZ7PZLIXlz7YNQmJQ7rVj31X60vOCD/Dlzmugi
         fiuZ3XWwf76wQ2oMkxof+AaB8qb0uYldaJ/6ZYqsDirPrSkSc8/JAdOvGiqkYhpLnScu
         CyqDnBsLZ+4q3QI5ebwlSRUZ98+tV3l4hP8qQoRm4H1yiV0idmL5GJ6O5y65fFb0O4la
         fXEHHe1aYOmpnoI9u2jrzJNlj+ASFnu7kc58s/eGjxS4xiLVmx71+K/PyjGIlKFBc3DQ
         ymO8BLMHgifuw6slQVBQBzOfg8zgJ+AVRj1+eCOxcCIGvegt4TsXWP4X+Kpq9KjksGLc
         li3g==
X-Gm-Message-State: ALoCoQnGrArM5pRZfSGRkJQJyG0g7Ebnopld2L9bM+vPOXHkTlMTgp1YLEwuzGEqZ/by9gAEe1LK
X-Received: by 10.43.154.196 with SMTP id lf4mr42911811icc.95.1419876892440;
 Mon, 29 Dec 2014 10:14:52 -0800 (PST)
Received: by 10.107.31.8 with HTTP; Mon, 29 Dec 2014 10:14:52 -0800 (PST)
In-Reply-To: <549D0B78.402@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261870>

On Thu, Dec 25, 2014 at 11:17 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On 12/19/2014 08:39 PM, Stefan Beller wrote:
>> Add a command line argument to the git push command to request atomic
>> pushes.
>>
>> [...]
>>
>> diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
>> index 21b3f29..da63bdf 100644
>> --- a/Documentation/git-push.txt
>> +++ b/Documentation/git-push.txt
>> @@ -9,7 +9,7 @@ git-push - Update remote refs along with associated objects
>>  SYNOPSIS
>>  --------
>>  [verse]
>> -'git push' [--all | --mirror | --tags] [--follow-tags] [-n | --dry-run] [--receive-pack=<git-receive-pack>]
>> +'git push' [--all | --mirror | --tags] [--follow-tags] [--atomic] [-n | --dry-run] [--receive-pack=<git-receive-pack>]
>>          [--repo=<repository>] [-f | --force] [--prune] [-v | --verbose]
>>          [-u | --set-upstream] [--signed]
>>          [--force-with-lease[=<refname>[:<expect>]]]
>> @@ -136,6 +136,11 @@ already exists on the remote side.
>>       logged.  See linkgit:git-receive-pack[1] for the details
>>       on the receiving end.
>>
>> +--atomic::
>> +     Use an atomic transaction on the remote side if available.
>> +     Either all refs are updated, or on error, no refs are updated.
>> +     If the server does not support atomic pushes the push will fail.
>> +
>> [...]
>
> I'd like to discuss the big picture around this feature. I don't think
> that any of these questions are blockers, with the possible exception of
> the question of whether "--atomic" should fall back to non-atomic if the
> server doesn't support atomic pushes.
>
>
> 1. Should "--atomic" someday become the default?
>
> You seem to imply that "--atomic" might become the default sometime in
> the future. (I realize that this patch series does not propose to change
> the default but let's talk about it anyway.) In the real world, the most
> common reason for an "--atomic" push to fail would be that somebody else
> has pushed to a branch since our last update, resulting in a non-ff
> error. Would I find out about such an error before or after I have
> transferred my objects to the server?

Another idea which I picked up from later patches in Ronnies original series
would be to have a hidden refs directory at the server side. Then the push
command would first transfer all the objects to this hidden refs space and at
the very end the server would just update all the refs atomically.

If that fails because somebody else has just pushed stuff to one of the
branches you intended to update, the changes are still at the server in the
hidden space. So if you just did a pull/merge on that branch and then
try to push
again, you would not have to transmit the objects again as they are
already there
at the server.

These changes in such a hidden space on the server side could be just normal
refs just not(never!) advertised to users.

>
> If I only find out at the end of the transfer, then it could be a pretty
> frustrating experience pushing a lot of references to a server over a
> slow connection. After waiting for a long transfer to complete the user
> would find out that the push was rejected and everything has to be done
> again from scratch. In such cases non-"--atomic" behavior might be
> attractive: any references that can be updated should be updated, so
> that not *all* of the objects have to be pushed again.
>
> Even *if* "--atomic" becomes the default, we would certainly want to
> support a "--no-atomic" (or "--non-atomic"?) option to get the old
> behavior. It might be a good idea to add that option now, so that
> forward-looking script writers can start explicitly choosing "--atomic"
> vs. "--no-atomic".

That's a good point. Though I am not sure where you'd want me to add the
--no-atomic flag.

I don't think we'll change send-pack as it's plumbing. So current unmaintained
scripts should continue to work the way they always did, i.e. having
the --no-atomic
behavior. The atomic behavior made default would just be part of git
push, which is
porcelain which is expected to change? But there it makes sense to have a
--no-atomic option in place.

>
>
> 2. Is this an option that users will want to specify via the command line?
>
> For scripts that want to insist on "atomic" updates, it is no problem to
> specify "--atomic" on the command line.
>
> But supposing that "--atomic" is a good default for some people, it
> would be awkward for them to have to specify it on every "git push"
> invocation. It therefore might be nice to have a configuration setting
> to choose whether "--atomic" is the default.

That's true. Would it make sense to include that in this series or delay it for
another series? I don't want to make the series so large again so it becomes
reviewer-unfriendly.

>
> Also (see above) it might be useful to set "--atomic" only for
> particular servers (for example, only for those to which you have a fast
> connection). This suggests that the "atomic/non-atomic" configuration
> should be settable on a per-remote basis.

So on the client side you want to configure on a per-remote basis which default
behavior to use and also at the server side if you advertise it at all?

>
>
> 3. What should happen if the server doesn't support atomic pushes?
>
> It seems to me that there are four reasonable behaviors WRT atomic
> pushes. I'll give them tentative names for the purposes of this discussion:
>
> "force" -- Insist on an atomic push, and fail if the server does not
> support atomic pushes
>
> "true" -- Use atomic push if supported by the server. If not, emit a
> warning and fall back to non-atomic.

I am not sure about this one. This only makes sense if atomic were the default
and the user doesn't really care about atomicity and just wants to get things
to the remote. But for this kind of users we want the "auto" option,
so the user is
not bothered by some warning they don't care about.

If the user however had the intention of using atomic behavior (i.e.
has specified
--atomic explicitly), the user probably wants to have the "force" behavior.

>
> "auto" -- Use atomic push if supported by the server. If not, silently
> fall back to non-atomic.
>
> "false" -- Push non-atomically regardless of whether the server supports
> atomic pushes.
>
> To make it practical to set "atomic" as a universal default, we will
> have to be able to deal with servers that don't (yet) support atomic
> pushes. Therefore, we would want to use either "true" or "auto" (as
> opposed to "force") as the default.
>
> Even in such a case, it would be nice for the user to be able to
> suppress any warnings for servers that don't support atomic updates. So
> if "true" becomes the default, then we might want to support "auto" as well.
>
> (One could argue that once "atomic" becomes the default, then anybody
> who has to deal with an old server should just set "non-atomic" as the
> default for that server. But even aside from the inconvenience to the
> user, this is not a good alternative. A user who made that change
> wouldn't benefit from atomic pushes once the server is upgraded to
> support them.)
>
> The command-line "--atomic" option is proposed to request "force"
> behavior. On the one hand that makes sense; the user has explicitly
> requested an atomic push, so the command should fail if it is not
> possible. But on the other hand, if a particular server doesn't (yet)
> support atomic pushes, what recourse does the user have but to run the
> push again non-atomically? So it might be more expedient for the
> "--atomic" option to be equivalent to "true" instead of "force". I don't
> have a strong opinion on this either way.

It doesn't take much time to find out if the server supports atomic pushes
as you don't have to send the objects, but just wait until the server has
advertised its refs and capabilities. Then the user could rerun the command
line without having the --atomic flag set or even using --no-atomic.

Thanks for your detailed discussion as I wasn't thinking so far ahead yet.

> I'd like to discuss the big picture around this feature. I don't think
> that any of these questions are blockers, with the possible exception of
> the question of whether "--atomic" should fall back to non-atomic if the
> server doesn't support atomic pushes.

If we make atomic default, then we should have this kind of fallback, if not
explicitly suppressed (i.e. the user should experience as little
rejection as possible,
warnings/hints may be ok? If the user really wants to do it
atomically, make it so)

For the current state after this patch series when atomic is not default (yet),
we probably don't need the fall back as we only talk about the "force"
option with
this series.


>
> Michael
>
> --
> Michael Haggerty
> mhagger@alum.mit.edu
>
