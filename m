From: Kevin Ballard <kevin@sb.org>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Mon, 21 Jan 2008 14:58:29 -0500
Message-ID: <373E260A-6786-4932-956A-68706AA7C469@sb.org>
References: <478E1FED.5010801@web.de> <alpine.LFD.1.00.0801161522160.2806@woody.linux-foundation.org> <B45968C6-3029-48B6-BED2-E7D5A88747F7@sb.org> <alpine.LFD.1.00.0801161707150.2806@woody.linux-foundation.org> <8AC4CC86-A711-483D-9F9C-5F8497006A1D@sb.org> <alpine.LFD.1.00.0801161959210.2806@woody.linux-foundation.org> <B719D4A2-0D05-4C55-95FC-AB880D58E1AC@wincent.com> <alpine.LFD.1.00.0801170842280.14959@woody.linux-foundation.org> <478F99E7.1050503@web.de> <alpine.LFD.1.00.0801171017460.14959@woody.linux-foundation.org> <F666FFD2-9777-47EA-BEF4-C78906CA8901@simplicidade.org> <alpine.LFD.1.00.0801171100330.14959@woody.linux-foundation.org> <Pine.LNX.4.64.0801181114430.817@ds9.cixit.se> <alpine.LFD.1.00.0801180909000.2957@woody.linux-foundation.org> <Pine.LNX.4.64.0801211509490.17095! @ds
 9.cixit.se> <440E4426-BFB5-4836-93DF-05C99EF204E6@sb.org> <alpine.LFD.1.00.0801! 210934400.2957@woody.linux-foundation.org> <C6C0E6A1-053B-48CE-90B3-8FFB44061C3B@sb.org> <alpine.LFD.1.00.0801211129130.2957@woody.linux-foundation.org>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: multipart/signed; boundary=Apple-Mail-17--699989902; micalg=sha1; protocol="application/pkcs7-signature"
Cc: Peter Karlsson <peter@softwolves.pp.se>,
	Mark Junker <mjscod@web.de>,
	Pedro Melo <melo@simplicidade.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Jan 21 20:59:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JH2nO-0003ht-Nf
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 20:59:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752487AbYAUT6e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 14:58:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752470AbYAUT6d
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 14:58:33 -0500
Received: from sd-green-bigip-145.dreamhost.com ([208.97.132.145]:55862 "EHLO
	randymail-a2.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752484AbYAUT6c (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Jan 2008 14:58:32 -0500
Received: from KBLAPTOP.WIFI.WPI.EDU (KBLAPTOP.WIFI.WPI.EDU [130.215.171.85])
	by randymail-a2.g.dreamhost.com (Postfix) with ESMTP id 8B5C8EEE8C;
	Mon, 21 Jan 2008 11:58:30 -0800 (PST)
In-Reply-To: <alpine.LFD.1.00.0801211129130.2957@woody.linux-foundation.org>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71322>


--Apple-Mail-17--699989902
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit

On Jan 21, 2008, at 2:41 PM, Linus Torvalds wrote:

> On Mon, 21 Jan 2008, Kevin Ballard wrote:
>>
>> I'm not saying it's forced on you, I'm saying when you treat  
>> filenames as
>> text, it DOESN'T MATTER if the string gets normalized. As long as  
>> the string
>> remains equivalent, YOU DON'T CARE about the underlying byte stream.
>
> Sure I do, because it matters a lot for things like - wait for it -  
> things
> like checksumming it.

I believe I already responded to the issue of hashing. In summary,  
just re-define your hash function to convert the string to a specific  
encoding. Sure, you'll lose some speed, but we're already assuming  
that it's worth taking a speed hit in order to treat filenames as  
strings (please don't argue this point, it's an opinion, not a factual  
statement, and I'm not necessarily saying I agree with it, I'm just  
saying it's valid).

>> Alright, fine. I'm not saying HFS+ is right in storing the  
>> normalized version,
>> but I do believe the authors of HFS+ must have had a reason to do  
>> that, and I
>> also believe that it shouldn't make any difference to me since it  
>> remains
>> equivalent.
>
> I've already told you the reason: they did the mistake of wanting to  
> be
> case-independent, and a (bad) case compare is easier in NFD.
>
> Once you give strings semantic meaning (and "case independent" implies
> that semantic meaning), suddenly normalization looks like a good  
> idea, and
> since you're going to corrupt the data *anyway*, who cares? You just
> created a file like "Hello", and readdir() returns "hello" (because  
> there
> was an old file under that name), and it's a lot more obviously  
> corrupt
> than just due to normalization.

Perhaps that is the reason, I don't know (neither do you, you're just  
guessing). However, my point still stands - as long as the string  
stays canonically equivalent, it doesn't matter to me if the  
filesystem changes the encoding, since I'm working at the string level.

>> Sure it does. Normalizing a string produces an equivalent string,  
>> and so
>> unless I look at the octets the two strings are, for all intents  
>> and purposes,
>> the same.
>
> .. but you *have* to look at the octets at some point. They're kind of
> what the string is built up of. They never went away, even if you  
> chose to
> ignore them. The encoding is really quite important, and is visible  
> both
> in memory and on disk.

Someone has to look at the octets, but it doesn't have to be me. As  
long as I use unicode-aware libraries and such, I can let the  
underlying system care about the byte order and my code will be clean.

> It's what shows up when you sha1sum, but it's also as simple as what  
> shows
> up when you do an "ls -l" and look at a file size.

It does? Why on earth should it do that? Filename doesn't contribute  
to the listed filesize on OS X.

kevin@KBLAPTOP:~> echo foo > foo; echo foo > foobar
kevin@KBLAPTOP:~> ls -l foo*
-rw-r--r--  1 kevin  kevin  4 Jan 21 14:50 foo
-rw-r--r--  1 kevin  kevin  4 Jan 21 14:50 foobar

It would be singularly stupid for the filesize to reflect the  
filename, especially since this means you would report different  
filesizes for hardlinks.

> It doesn't matter if the text is "equivalent", when you then see the
> differences in all these small details.
>
> You can shut your eyes as much as you want, and say that you don't  
> care,
> but the differences are real, and they are visible.

Visible at some level, sure, but not visible at the level my code  
works on. And thus, I don't have to care about it.

>> Decomposing and recomposing shouldn't lose any information we care  
>> about -
>> when treating filenames as text, a<COMBINING DIARESIS> and <A WITH  
>> DIARESIS>
>> are equivalent, and thus no distinction is made between them. I'm  
>> not sure
>> what other information you might be considering lost in this case.
>
> You're right, I messed up. I used a non-combining diaeresis, and  
> you're
> right, it doesn't get corrupted. And I think that means that if  
> Apple had
> used NFC, we'd not have this problem with Latin1 systems (because  
> then the
> UTF-8 representation would be the same).

I'm not sure what you mean. The byte sequence is different from Latin1  
to UTF-8 even if you use NFC, so I don't think, in this case, it makes  
any difference whether you use NFC or NFD. Yes, the codepoints are the  
same in Latin1 and UTF-8 if you use NFC, but that's hardly relevant.  
Please correct me if I'm wrong, but I believe Latin1->UTF-8->Latin1  
conversion will always produce the same Latin1 text whether you use  
NFC or NFD.

> So I still think that normalization is totally idiotic, but the  
> thing that
> actually causes most problems for people on OS X is that they chose  
> the
> really inconvenient one.

The only reason it's particularly inconvenient is because it's  
different from what most other systems picked. And if you want to  
blame someone for that, blame Unicode for having so many different  
normalization forms.

-Kevin Ballard

-- 
Kevin Ballard
http://kevin.sb.org
kevin@sb.org
http://www.tildesoft.com



--Apple-Mail-17--699989902
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
DxcNMDgwMTIxMTk1ODI5WjAjBgkqhkiG9w0BCQQxFgQUGPyXQ6lk/7Awcgeb0/0+TYceKOYwgYUG
CSsGAQQBgjcQBDF4MHYwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5n
IChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENB
AhA7BvASr5axFtB1ASMViII1MIGHBgsqhkiG9w0BCRACCzF4oHYwYjELMAkGA1UEBhMCWkExJTAj
BgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJz
b25hbCBGcmVlbWFpbCBJc3N1aW5nIENBAhA7BvASr5axFtB1ASMViII1MA0GCSqGSIb3DQEBAQUA
BIIBACVR9RGZ6SAo0oo46fP0Hs2K6uC8OcbX/Zg2jL0Yhvz7RvNFMOcrfgQ5v6Yu8HtKWUD8mxwV
zZrOi6uHzz6A7bBixvogCifXZ7bYb3MsNDAxm3EEqgWwQeneRk3blhjnW5FaZmFz905fgQ6i4npa
sCVWUSR1mmR7ZLABdND7xltgGdZFD9BPDiQPQe06lHgsIF3edJf45Lhsf+QM9lyGdo30hibkCG0/
K4CvC+/apghLz+45PIWsHIopZqLHXmZtZf2z3ZLOL9zNOAULVCNI/pioTxrPi9+wBIreoJ1iylKl
ruESgWWYuzAdoIuhBh7v9BsMscNe5sYWArQd3VbxyO0AAAAAAAA=

--Apple-Mail-17--699989902--
