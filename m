From: Kevin Ballard <kevin@sb.org>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Wed, 16 Jan 2008 23:30:01 -0500
Message-ID: <4C21C1AF-40B0-48C7-8F0E-2DAF3C5FAB29@sb.org>
References: <478E1FED.5010801@web.de> <m33asxn2gt.fsf@roke.D-201> <65026F2B-5CE8-4238-A9AB-D3545D336B41@sb.org> <200801162251.54219.jnareb@gmail.com> <1574A90A-8C45-46AD-9402-34AE6F582B3F@sb.org> <alpine.LFD.1.00.0801161424040.2806@woody.linux-foundation.org> <7652B11D-9B9F-45EA-9465-8294B701FE7C@sb.org> <alpine.LFD.1.00.0801161522160.2806@woody.linux-foundation.org> <B45968C6-3029-48B6-BED2-E7D5A88747F7@sb.org> <alpine.LFD.1.00.0801161707150.2806@woody.linux-foundation.org> <8AC4CC86-A711-483D-9F9C-5F8497006A1D@sb.org> <alpine.LFD.1.00.0801161959210.2806@woody.linux-foundation.org>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: multipart/signed; boundary=Apple-Mail-10-1046185946; micalg=sha1; protocol="application/pkcs7-signature"
Cc: Jakub Narebski <jnareb@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mark Junker <mjscod@web.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jan 17 05:30:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFMOj-0004EM-87
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 05:30:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752986AbYAQEaI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 23:30:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752653AbYAQEaI
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 23:30:08 -0500
Received: from mailbigip.dreamhost.com ([208.97.132.5]:33390 "EHLO
	randymail-a2.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751326AbYAQEaG (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Jan 2008 23:30:06 -0500
Received: from KBALLARD.RES.WPI.NET (KBALLARD.RES.WPI.NET [130.215.239.91])
	by randymail-a2.g.dreamhost.com (Postfix) with ESMTP id 6E636EEE86;
	Wed, 16 Jan 2008 20:30:04 -0800 (PST)
In-Reply-To: <alpine.LFD.1.00.0801161959210.2806@woody.linux-foundation.org>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70823>


--Apple-Mail-10-1046185946
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit

On Jan 16, 2008, at 11:08 PM, Linus Torvalds wrote:

> On Wed, 16 Jan 2008, Kevin Ballard wrote:
>>
>> I believe it exists because HFS+ was created at a time when the Mac  
>> was moving
>> from a multi-encoding world (which was a nightmare) to a Unicode  
>> world and
>> they wanted to remove ambiguity in filenames. But I wasn't around  
>> when they
>> made this decision so this is just a guess.
>
> I do agree. And I think starting out case-insensitive (something  
> they must
> really hate by now) also made it less of an issue. When you're
> case-insensitive, the issues with any UTF-8 normalization are simply
> swamped by all the issues of case, so you probably don't even think  
> about
> it very much.

Those of us who grew up on a case-insensitive filesystem don't find  
there to be any problem with it. I can count on one hand the number of  
times I've run into a problem caused by a case-insensitive filesystem.  
That number is 1. And that 1 time is when git screwed up trying to  
track CS4536 and cs4536 in the same directory (see earlier thread).

> The big problem with any name rewriting is that I can open file  
> 'xyz', and
> I literally have a very hard time knowing whether that file I know I
> opened and created has anything to do with the file 'Xyz' that I see  
> when
> I do a readdir().

That's only true if you don't know what type of filesystem you're on.  
And, in the vast majority of cases (in fact, a content tracker is the  
only exception I can think of), it doesn't matter. If the user said  
'xyz' and you can stat() it, great, that's what the user wanted! Just  
because it's really called 'Xyz' on the filesystem doesn't make any  
difference.

> Are they the same? Maybe. But it's literally hard to tell on OS X. I  
> can
> do an fstat() on my file descriptor and on the directory entry, and if
> they get the same d_ino they *probably are the same entry, but even  
> then
> it actually could have been a hardlink (and my 'xyz' is really  
> *another*
> name for it entirely, and the filesystem is actually case-sensitive  
> and
> 'Xyz' was a *different* name that somebody else did!).
>
> See? If you're creating a content tracker, these kinds of issues are  
> not
> "idle chatter". It's really *really* important. Was that file the  
> one I
> was told to track? Or was it a temporary file that was just  
> hardlinked?

But git is a content tracker, so even if it's really a different  
hardlink that shouldn't matter, it's still referencing the same  
content. Go ahead and track whatever name the user specified  
originally, as long as it maps to a file on disk with the expected  
content you're set. If the file is really called 'foo' and I told git  
to track 'Foo', I'm perfectly happy with it continuing to think 'foo'  
is 'Foo' until I use 'git mv Foo foo'.

> This is why case-insensitivity is so hard: you have a very real  
> "aliasing"
> on the filesystem level, where all those really *different*  
> pathnames end
> up being the same thing.

I don't see that as being a problem. Think of it, if you will, as if  
every single file simply had an implicit hardlink for every possible  
case or normalization variant. The whole point of the filename is that  
it is meta-information, used as an identifier and not as actual  
content, and thus it is perfectly fine for it to be a real string,  
subject to interpretation, rather than treated as a sacred binary blob  
like content is. The whole purpose of the name is to identify the  
inode in question, and case and normalization aren't particularly  
relevant here. As long as we can identify the file, we're happy.

> And all the same issues show up with utf-8 rewriting, so if you  
> normalize
> utf-8 names, you actually end up having almost all the same problems  
> that
> a case-insensitive filesystem has. They're just much rarer in  
> practice, so
> you just won't hit them as often - but when you do, they are equally
> painful!
>
> (In fact, they can be a whole lot *more* painful, because now they are
> really rare, and really confusing when they happen!)
>
> But if you come from a case-insensitive background, all the UTF-8
> rewriting really looks like such a small problem compared to all the
> horrid problems that you had with different locales and cases, so I
> suspect they didn't even realize what a big mistake they did!

Again, as someone who grew up in a case-insensitive world, there's no  
problems here. I wish I could tell you that it causes problems, I wish  
I could agree with you, but I can't.

-Kevin Ballard

-- 
Kevin Ballard
http://kevin.sb.org
kevin@sb.org
http://www.tildesoft.com



--Apple-Mail-10-1046185946
Content-Disposition: attachment;
	filename=smime.p7s
Content-Type: application/pkcs7-signature;
	name=smime.p7s
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIGMjCCAusw
ggJUoAMCAQICEDsG8BKvlrEW0HUBIxWIgjUwDQYJKoZIhvcNAQEFBQAwYjELMAkGA1UEBhMCWkEx
JTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQ
ZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBMB4XDTA3MDQyMzIxMjM0OVoXDTA4MDQyMjIxMjM0
OVowVzEQMA4GA1UEBBMHQmFsbGFyZDEOMAwGA1UEKhMFS2V2aW4xFjAUBgNVBAMTDUtldmluIEJh
bGxhcmQxGzAZBgkqhkiG9w0BCQEWDGtldmluQHNiLm9yZzCCASIwDQYJKoZIhvcNAQEBBQADggEP
ADCCAQoCggEBAN/koURrN2ndrAiuAuHHrdFz+hLGQ7ZsXloGnObjALGOFY3Kmk2FCwAJPIha5GfM
YFmZIoqxs+DbOWOn6KZ9hcQ5wf4EOgokayrEs3G72T+G8ZE4aXrw0CWJzKLjaIQeDZNZoHA44jlZ
dG70wtZske898IoPz6YHpkcXiulllATfd8Pa7EgjPri5hKFiRXKI52OsOQTX6cNMMZJUIm8DvfQ5
jmDyAtywNZGSGeUAMbWnpuLq7H18zpye2Q1hr+p4kucazMb+i7OHXPvX7yx2jMjhN5jw/gYkuzQQ
JExp1fJyAZQ/av/ZgaxWchhhi4ziFXIlX3B09DTlOQlF53P3fi0CAwEAAaMpMCcwFwYDVR0RBBAw
DoEMa2V2aW5Ac2Iub3JnMAwGA1UdEwEB/wQCMAAwDQYJKoZIhvcNAQEFBQADgYEAw/qc6zq+0Qy2
XaodDlt2L6Vq1DzaVWjV152BFjidmsyhyCkCuyYdAcDp17opIfrNCBbOX5DdY6cpFpnSCxCZeIEB
PDc3TaaFPtzr8qrpcNDohRSdt+qFLUeMHzlidAiAjvjI3tPKv3JLTakWdQR/XPHsg4mWoaVQU2hM
HOQBw8EwggM/MIICqKADAgECAgENMA0GCSqGSIb3DQEBBQUAMIHRMQswCQYDVQQGEwJaQTEVMBMG
A1UECBMMV2VzdGVybiBDYXBlMRIwEAYDVQQHEwlDYXBlIFRvd24xGjAYBgNVBAoTEVRoYXd0ZSBD
b25zdWx0aW5nMSgwJgYDVQQLEx9DZXJ0aWZpY2F0aW9uIFNlcnZpY2VzIERpdmlzaW9uMSQwIgYD
VQQDExtUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgQ0ExKzApBgkqhkiG9w0BCQEWHHBlcnNvbmFs
LWZyZWVtYWlsQHRoYXd0ZS5jb20wHhcNMDMwNzE3MDAwMDAwWhcNMTMwNzE2MjM1OTU5WjBiMQsw
CQYDVQQGEwJaQTElMCMGA1UEChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UE
AxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVtYWlsIElzc3VpbmcgQ0EwgZ8wDQYJKoZIhvcNAQEBBQAD
gY0AMIGJAoGBAMSmPFVzVftOucqZWh5owHUEcJ3f6f+jHuy9zfVb8hp2vX8MOmHyv1HOAdTlUAow
1wJjWiyJFXCO3cnwK4Vaqj9xVsuvPAsH5/EfkTYkKhPPK9Xzgnc9A74r/rsYPge/QIACZNenpruf
ZdHFKlSFD0gEf6e20TxhBEAeZBlyYLf7AgMBAAGjgZQwgZEwEgYDVR0TAQH/BAgwBgEB/wIBADBD
BgNVHR8EPDA6MDigNqA0hjJodHRwOi8vY3JsLnRoYXd0ZS5jb20vVGhhd3RlUGVyc29uYWxGcmVl
bWFpbENBLmNybDALBgNVHQ8EBAMCAQYwKQYDVR0RBCIwIKQeMBwxGjAYBgNVBAMTEVByaXZhdGVM
YWJlbDItMTM4MA0GCSqGSIb3DQEBBQUAA4GBAEiM0VCD6gsuzA2jZqxnD3+vrL7CF6FDlpSdf0wh
uPg2H6otnzYvwPQcUCCTcDz9reFhYsPZOhl+hLGZGwDFGguCdJ4lUJRix9sncVcljd2pnDmOjCBP
ZV+V2vf3h9bGCE6u9uo05RAaWzVNd+NWIXiC3CEZNd4ksdMdRv9dX2VPMYIDEDCCAwwCAQEwdjBi
MQswCQYDVQQGEwJaQTElMCMGA1UEChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoG
A1UEAxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVtYWlsIElzc3VpbmcgQ0ECEDsG8BKvlrEW0HUBIxWI
gjUwCQYFKw4DAhoFAKCCAW8wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUx
DxcNMDgwMTE3MDQzMDAyWjAjBgkqhkiG9w0BCQQxFgQUi2GTqxu7IQd5Ca60v+K7jyWspBowgYUG
CSsGAQQBgjcQBDF4MHYwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5n
IChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENB
AhA7BvASr5axFtB1ASMViII1MIGHBgsqhkiG9w0BCRACCzF4oHYwYjELMAkGA1UEBhMCWkExJTAj
BgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJz
b25hbCBGcmVlbWFpbCBJc3N1aW5nIENBAhA7BvASr5axFtB1ASMViII1MA0GCSqGSIb3DQEBAQUA
BIIBAEIFCHeWQH6z4UkZh4d87TPtBvKWT3BlKWRBtF+/9tC/VuxG/VonRf8v2nJr0Gdn740ozZYt
UJsRceclkKq3QfjuSX7yzual64wxICHY9P+Wy7CxzaKijRjBv7DnCvZD4/nb700gbZmjkC24virY
FuI/rV0NSriYCxMkxn64E31TmEx2KUJpIqTGanCgaAcEBG4AiGMb55WJ2MwgLXKm6beEYQ9ICZzP
GLHpxryGCkd3vkdmt8+BiqRsiFtZyBFP/uY7AfdCG8pccUOhTYiA9l8LZ5c4QSnpnqtC4OR4AVNb
KqfIhvrDeWCjc9XVtSpbwVZjrMlmXCwLjib0NZAyQj4AAAAAAAA=

--Apple-Mail-10-1046185946--
