From: Martin Pettersson <martin@siamect.com>
Subject: Re: Git with Lader logic
Date: Fri, 27 Mar 2015 16:32:30 +0000 (UTC)
Message-ID: <loom.20150327T170836-560@post.gmane.org>
References: <5F9B9EBF-CD4D-42A8-8A0C-9806702231A1@icloud.com> <loom.20150327T160645-181@post.gmane.org> <xmqqegoawiu0.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 27 17:33:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YbXC3-0006R6-4W
	for gcvg-git-2@plane.gmane.org; Fri, 27 Mar 2015 17:33:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964839AbbC0QdH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Mar 2015 12:33:07 -0400
Received: from plane.gmane.org ([80.91.229.3]:45487 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752745AbbC0QdE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Mar 2015 12:33:04 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1YbXBo-0006HL-Hq
	for git@vger.kernel.org; Fri, 27 Mar 2015 17:32:57 +0100
Received: from ppp-171-96-7-236.revip8.asianet.co.th ([171.96.7.236])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 27 Mar 2015 17:32:56 +0100
Received: from martin by ppp-171-96-7-236.revip8.asianet.co.th with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 27 Mar 2015 17:32:56 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 171.96.7.236 (Mozilla/5.0 (X11; Linux) AppleWebKit/538.15 (KHTML, like Gecko) Chrome/18.0.1025.133 Safari/538.15 Midori/0.5)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266376>

Junio C Hamano <gitster <at> pobox.com> writes:

> 
> Martin Pettersson <martin <at> siamect.com> writes:
> 
> > I use Git for versioning PLC program written for Beckhoff TwinCAT v2 that 
> > saves the files in binary format.  
> > You can probably do the same for most other systems as well.   
> >   
> > My way of doing it is... 
> > I have a batch file that starts TwinCAT including a file that tell Twincat to
> > open my PLC program and export it into a text based format. 
> > After that the script opens git gui and gitk.  
> >   
> > I have one script like this for each plc program. 
> > It is quite effcient, the whole procedure only takes a double click and 
> > less than 10 seconds and you have git gui up and you can see your 
> > changes in pure text, commit and push.   
> > I commit both the exported text files and the binary  because the binary
> > is the one I edit.   
> > This has been working very well for many years....
> 
> Let me check if I got your scheme correctly.
> 
>  - You need to track PLC program files, whose native format is
>    binary and is not very amenable to textual processing like diff
>    and merge
> 
>  - But you can tell TwinCat to export that binary file to text (and
>    presumably you can tell TwinCat to read that exported text file),
>    and the text format is human-readable.
> 
>  - You use a script that calls TwinCat to export the binary into
>    text as a clean filter, and what is checked into Git is the
>    exported text representation.
> 
>  - You use another script that calls TwinCat to convert the exported
>    text back to the binary as a smudge filter, and what is checked
>    out to the working tree is the native binary format file.
> 
> Is that what is going on?  I can imagine how that arrangement would
> work (after all, that is how clean/smudge filters are designed to be
> used).
> 
> Thanks.
> 
> 

Well  you got it right, but I "almost" never convert the 
exported textfiles back into TwinCat.  

The exported textfiles is not really suitable
for merging as they have a proprietary format, 
but they are human readable and it helps a lot 
to be able to see what changes I made at a certain commit.  
  
I do commit both the exported text files and the original binary files.
Recreating the binary by imprting the textfiles can be done.
I just don't do it because it is easier to commit the binary at 
the same time when I commit the exported text files. 
That way I can just checkout any version and rebuild the project 
and  reload it in the machine. 

My script is just a batch file that I double click on. It is not using 
any of the hooks that git comes with. 

Here is an example, I hope it keeps the formatting  (windows batch file):

Set WorkingFolder="C:\Documents and Settings\Me\projectname\Beckhoff"
Set CommandFile="do_.cmd"
Set TwinCatFile="plc_program_name.prx"
Set ExportFile="exports\intermediate_plate.exp"
Set ExportFolder="exports\modules"

cd %WorkingFolder%

echo project expmul %ExportFolder% > %CommandFile%
echo project export %ExportFile% >> %CommandFile%
echo file quit  >> %CommandFile%

del /f /q %ExportFile%
del /f /q %ExportFolder%\*.*
C:\TwinCAT\Plc\TCatPlcCtrl.exe %TwinCatFile% /cmd %CommandFile%
del /f %CommandFile%

call git gui &
call gitk --all &

Take care
Martin
