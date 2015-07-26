From: Dangling Pointer <danglingpointer@outlook.com>
Subject: RE: FeatureRequest: Build improvements for Windows
Date: Sun, 26 Jul 2015 15:47:32 +0000
Message-ID: <BAY169-W133FCD817F235BF1799BF8FA78F0@phx.gbl>
References: <BAY169-W8210AC5C69796A61AD2236A78F0@phx.gbl>,<BAY169-W30CD27F2F7606F4DF52944A78F0@phx.gbl>,<CA+P7+xpcXAck4HVFGLa4c9JquBTHaD-yZuuO4s0sAfJ50c+NxA@mail.gmail.com>,<BAY169-W84A0734CACD22511DE9B5BA78F0@phx.gbl>
 <BAY169-W75E45600196FA9E4B9A20CA78F0@phx.gbl>,<02471E10AEC7447DA1B50E7F44555786@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jacob Keller <jacob.keller@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Sun Jul 26 17:47:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZJO9M-00025c-5X
	for gcvg-git-2@plane.gmane.org; Sun, 26 Jul 2015 17:47:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755190AbbGZPre (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Jul 2015 11:47:34 -0400
Received: from bay004-omc4s5.hotmail.com ([65.54.190.207]:60586 "EHLO
	BAY004-OMC4S5.hotmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754363AbbGZPrd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Jul 2015 11:47:33 -0400
Received: from BAY169-W133 ([65.54.190.200]) by BAY004-OMC4S5.hotmail.com over TLS secured channel with Microsoft SMTPSVC(7.5.7601.23008);
	 Sun, 26 Jul 2015 08:47:33 -0700
X-TMN: [0Qd8TFlk8FqsSif6R9KMuBdHWIgZk+N+]
X-Originating-Email: [danglingpointer@outlook.com]
Importance: Normal
In-Reply-To: <02471E10AEC7447DA1B50E7F44555786@PhilipOakley>
X-OriginalArrivalTime: 26 Jul 2015 15:47:33.0037 (UTC) FILETIME=[62DEFDD0:01D0C7BA]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274643>

I searched in code and found instances of #ifdef _MSC_VER in https://github.com/git/git (original repository, not the fork).

I am coming from github, where I have found many native lib repositories have two build files, build.sh and build.cmd with

some windows-specific code turds like #ifdef _MSC_VER etc. which nobody appreciate because CL.exe up until last VS release

wasn't C99 complaint. This has changed with VS2015.


If git/git does not share this philosophy of having a build file for both nix and win, then I wonder why do we even have MS compiler

directives in git codebase in first place? That was the main source of confusion.


If the repo owner is willing to drop the old compiler support for Windows, since many windows users do not build from source

and tend to download the compiled binaries anyway.  If they want, they can always use MinGW and VS2015 to build. 


The idea is to keep the codebase clean from outdated _MSC_VER conditions. In this age,

free CI service (like AppVeyor) will build your code with latest compiler (MinGW GCC and MSVCR 2015) in a matter of minutes

and then make the release artifacts available for download. I really don't see any point in still using 8 years old compiler on a 15

years old OS when we can just throw a .yml (appveyor config) file in the repo root and let the cloud handle the build business and

verify the build by running tests. (well we are still using mailing lists, aren't we ;-)


Besides, I had no idea about this fork: https://github.com/msysgit/git but it seems to be falling behind significantly from the

upstream master (git/git).



----------------------------------------
> From: philipoakley@iee.org
> To: danglingpointer@outlook.com
> CC: jacob.keller@gmail.com; git@vger.kernel.org
> Subject: Re: FeatureRequest: Build improvements for Windows
> Date: Sun, 26 Jul 2015 12:27:19 +0100
>
> (In-line posting preferred; top-posting deprecated ;-)
> (retain all cc's)
>
>> Hmm, it is already happening, isn't it? There is already a support of
>> MSVCR in git's code base. I am referring to replacing that current
>> support of 'older' MSVCR in favor of the latest one, so to make the
>> git's code base comparatively coherent and organized (as some/many
>> instances of #ifdef _MSC_VER and #if define (_MSC_VER) && _MSC_VER <
>> xxx etc. will be gone, for instance we don't need fallback for sprint
>> or snprintf since C99 std support for those is provisioned).
>>
>
> It's not clear if you (DP) are asking about using being able to use the
> Visual Studio IDE and gui to help visualise and develop the code, or to
> simply use the underlying MS compiler when making (using the Makefile)
> the Git code base.
>
> One can compile the codebase using the MS compiler (given a suitable
> environment, and setting the right Makefile flags), but that may not be
> what you were thinking of.
>
> The Windows team recently decided that the older Msysgit approach should
> be retired (can't find the link just now) and a new approach based on
> Msys2 started (http://git-for-windows.github.io/ and
> https://github.com/git-for-windows/git/wiki/FAQ). This is nearing
> completion.
>
> Meanwhile I have been working on fixing the msvc-build script, which can
> produce a git.sln and associated files (targeted originally at VS2008),
> and is now at the 'Validate this with the Windows guys' stage
> (http://marc.info/?l=git&m=143750907804881&w=2 et.seq.).
>
> My code, for the new G4W SDK, has been rebased from the msygit version,
> and is now at https://github.com/git-for-windows/git/pull/256
>
> Does that help for creating an IDE compilable version?
>
> Also, many thanks for yournote about the new VS Community edition (I'm
> still mainly working on an XP notebook for ease of carry).
>
> As an open community of independently minded folks it can tae a time to
> gel around a reasonably common approach, especially as Git will always
> be primarily focussed on Linux (it **is** the Linux (Linus's) VCS!).
>
>>
>>>> From: jacob.keller@gmail.com
>>>> On Sat, Jul 25, 2015 at 11:23 PM, Dangling Pointer
>>>> <danglingpointer@outlook.com> wrote:
>>>>> Hello,
>>>>>
>>>>> In my understanding, the ratio between the mere consumers of git on
>>>>> Windows vs. people who compile git for Windows is 100,000 : 1. If
>>>>> there is a breaking change in the workflow of the latter set, who
>>>>> use Visual Studio to build git from source, I assume that is doable
>>>>> given a good reason, hence this post.
>>>>>
>>>>> With VS 2015, C99 support is "finally" added with some C11 features
>>>>> as well. See this blog:
>>>>> http://blogs.msdn.com/b/vcblog/archive/2015/06/19/c-11-14-17-features-in-vs-2015-rtm.aspx.
>>>>> One of the edition of new VS is Community edition, which is like
>>>>> professional edition but is free (also much superior than Express
>>>>> edition) and meant for open source projects. VS2015 also has the
>>>>> ability to target compiler for Wind-XP.
>>>>>
>>>>
>>>> I think the big issue is whether it has support for the various unix
>>>> interfaces and unix shell commands we use. MinGW/MSYS comes with
>>>> support for the unix interface, which I don't believe is that
>>>> actually
>>>> supported via MSYS and I don't know if VS2015 is supported? I don't
>>>> think it's due to the C99 but due to need of posix interface which
>>>> is
>>>> not normally (fully) provided by Windows.
>
> Git's code retains a C89 compatibility (IIUC).
>
>>>>
>>>> Regards,
>>>> Jake --
> --
> Philip
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html 		 	   		  