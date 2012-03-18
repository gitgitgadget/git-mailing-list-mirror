From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Clone fails on a repo with too many heads/tags
Date: Sun, 18 Mar 2012 19:04:18 +0700
Message-ID: <CACsJy8DRLQiXE83vNu2J5_jUfYxa-StBVYwzn2eoraXUE2fEEg@mail.gmail.com>
References: <loom.20120318T083216-96@post.gmane.org> <loom.20120318T121808-344@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Ivan Todoroski <grnch_lists@gmx.net>
X-From: git-owner@vger.kernel.org Sun Mar 18 13:04:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9Er1-0000L6-HX
	for gcvg-git-2@plane.gmane.org; Sun, 18 Mar 2012 13:04:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755115Ab2CRMEu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 18 Mar 2012 08:04:50 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:49666 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755088Ab2CRMEu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Mar 2012 08:04:50 -0400
Received: by wibhq7 with SMTP id hq7so2734104wib.1
        for <git@vger.kernel.org>; Sun, 18 Mar 2012 05:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=7GzpNaDneTpG4U/+KLg/EgCFjOOWZed7LuDt/JW5SYQ=;
        b=WN1om0vBfK5JvjKfGHAOkfk1yQoruU9voxWEm4q4DeFe51Lu9F74eVjZAOBv8pXKqp
         K2LgE1lLTMkEGQwmIWNWaqDTIkAbHeQArxIMV2sxndH1bzqBhQknEpWJ7QKC9rEHTE4i
         z5UaO7wj9XT95ZVAZrY4Es8YCEeB+12d9DRfuuSYnwJUTAGLYOiC1yzfSvF/WzUsaM8f
         8D85ABwhT9BsUGx9GNxGT4fsRVGfRZCP6/QSN/SymTMb4trQILffGu/mxWWQPvhR7z96
         u6KeaDpbQslrVHmxParlaXlJY8B0wFX26ps/nfpTOp+OguzMUyZc18yjNYfiAjzK9UY6
         e5KA==
Received: by 10.216.135.225 with SMTP id u75mr4692698wei.97.1332072288815;
 Sun, 18 Mar 2012 05:04:48 -0700 (PDT)
Received: by 10.223.109.144 with HTTP; Sun, 18 Mar 2012 05:04:18 -0700 (PDT)
In-Reply-To: <loom.20120318T121808-344@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193381>

I had a look but could not come up with a simple solution for this. CC
Shawn who knows smart-http really well.

On Sun, Mar 18, 2012 at 6:37 PM, Ivan Todoroski <grnch_lists@gmx.net> w=
rote:
> Ivan Todoroski <grnch_lists <at> gmx.net> writes:
>> Now share this repo using the Smart HTTP transport (git-http-backend=
) and
> then
>> try cloning it in a different directory. This is what you would get:
>>
>> $ git clone http://localhost/.../too-many-refs/.git
>> Cloning into 'too-many-refs'...
>> fatal: cannot exec 'fetch-pack': Argument list too long
>>
>> [...]
>>
>> The solution is conceptually simple: if the list of refs results in =
a too
> long
>> command line, split the refs in batches and call fetch-pack multiple=
 times
> such
>> that each call is under the cmdline limit:
>>
>> git fetch-pack --stateless-rpc --lock-pack ...<first batch of refs>.=
=2E.
>> git fetch-pack --stateless-rpc --lock-pack ...<second batch of refs>=
=2E..
>> ...
>> git fetch-pack --stateless-rpc --lock-pack ...<last batch of refs>..=
=2E
>
>
> BTW, I didn't want to sound like I am expecting or demanding a fix. I=
f the
> experienced Git devs lack the time or inclination to work on this bug
> (understandable), I am certainly willing to try it myself. My C skill=
s are a
> bit rusty and I'm not very familiar with the Git codebase, but I will=
 do my
> best to follow Documentation/SubmittingPatches as well as the existin=
g code
> structure.
>
> I will need a few pointers to get me started in the right direction t=
hough...
>
>
> 1) Is splitting the cmdline in batches and executing fetch-pack multi=
ple times
> the right approach? If you have another solution please suggest.
>
>
> 2) Should I add the test case for this bug to existing scripts like t=
/t5551-
> http-fetch.sh and t/t5561-http-backend.sh, or should I create a new t=
est script
> under t/ following their example? There will probably be only one tes=
t case for
> this bug, basically the script I pasted in the original email to repr=
oduce it.
>
>
> 3) What would be the most portable way to get the cmdline length limi=
t between
> POSIX and Windows? Would something like this be acceptable:
>
> #ifder _WIN32
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int cmdline_limit =3D 32767;
> #else
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int cmdline_limit =3D sysconf(_SC_ARG_MAX)=
;
> #endif
>
> I couldn't actually find a Windows API to get the cmdline limit, but =
this blog
> post by one of the Windows people tells the value:
>
> http://blogs.msdn.com/b/oldnewthing/archive/2003/12/10/56028.aspx
>
>
> 4) Should this problem be fixed only in remote-curl.c:fetch_git() or =
should it
> be solved more generally in run-command.c:start_command(), which is u=
sed by
> fetch_git() for the actual invocation?
>
> If this is fixed only in remote-curl:fetch_git(), then the same logic=
 would
> need to be open coded in any other such place that might be found. Ar=
e you
> aware of any other internal sub-commands that put all refs on the com=
mand line
> and could be susceptible to the same issue?
>
>
> If it's fixed at a lower level in run-command.c:start_command(), the =
logic
> would become available to any other sub-command that needs it.
>
> However, this would mean that struct child_process as well as struct =
rpc_state
> would need an additional field that would tell whether the command is=
 safe to
> execute in multiple batches and how many of the arguments at the begi=
nning of
> child_process.argv must be preserved on every invocation (the switche=
s and
> such).
>
> Something like child_process.split_after, which if non-zero would mea=
n that
> start_command() is free to invoke the command multiple times when arg=
v exceeds
> the cmdline limit, by grouping any arguments after argv[split_after] =
in smaller
> batches for each invocation.
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml



--=20
Duy
