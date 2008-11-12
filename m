From: "Alexander Gavrilov" <angavrilov@gmail.com>
Subject: Re: Bug: UTF-16, UCS-4 and non-existing encodings for git log result in incorrect behavior
Date: Wed, 12 Nov 2008 19:58:11 +0300
Message-ID: <bb6f213e0811120858lbcefa25v47a4fb14d8537839@mail.gmail.com>
References: <85647ef50811120532h778769ddx69f0b111dbad359a@mail.gmail.com>
	 <alpine.DEB.1.00.0811121521390.30769@pacific.mpi-cbg.de>
	 <85647ef50811120727j730cb6e3lf4103c200d042fb9@mail.gmail.com>
	 <alpine.DEB.1.00.0811121714280.30769@pacific.mpi-cbg.de>
	 <bb6f213e0811120817i20d5c0ajf0c9e289c11387a6@mail.gmail.com>
	 <alpine.DEB.1.00.0811121740120.30769@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Constantine Plotnikov" <constantine.plotnikov@gmail.com>,
	git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Nov 12 17:59:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0J40-0000mC-Cr
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 17:59:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751324AbYKLQ6N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2008 11:58:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751261AbYKLQ6N
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Nov 2008 11:58:13 -0500
Received: from wf-out-1314.google.com ([209.85.200.175]:63837 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751060AbYKLQ6M (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2008 11:58:12 -0500
Received: by wf-out-1314.google.com with SMTP id 27so502590wfd.4
        for <git@vger.kernel.org>; Wed, 12 Nov 2008 08:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=BxwwPIKLW63Z8N9B4t3y7Zgo95FX67FOYTqWp6WyyYg=;
        b=hkdRIbNA72+A15et+4rqyv60xcbaiMoDzXtYABS3fkWYnHnc1EwHOvWI72OyJjftsK
         cvLZZxm0/6Zf+IDeot2qrg1bm7iOjaqaD5wFchuTWd/yIomgl6LeQTIaOczDvjjLPrzD
         qWmzk88COkM+e/eEiOVbqLePnPV04Li7dnDMc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=qMLqH8b1v2oblLcA5h7m2Mr5EnNvLS4o0oanOs7joHP65n94CsCNOPPvPQJBaPoh0/
         1CcQx9WKK4kbqjUjUQANNlXI2vKypLftr7h7rMB5e091er35oypaw4M09I4CGEhDbOhH
         43fQQOialI/Dr/6Ay+0ofNEgzYJZxxmNRQ4cY=
Received: by 10.142.221.11 with SMTP id t11mr3575773wfg.238.1226509091422;
        Wed, 12 Nov 2008 08:58:11 -0800 (PST)
Received: by 10.142.216.21 with HTTP; Wed, 12 Nov 2008 08:58:11 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0811121740120.30769@pacific.mpi-cbg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100769>

On Wed, Nov 12, 2008 at 7:42 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> On Wed, 12 Nov 2008, Alexander Gavrilov wrote:
>> On Wed, Nov 12, 2008 at 7:15 PM, Johannes Schindelin
>> <Johannes.Schindelin@gmx.de> wrote:
>> > On Wed, 12 Nov 2008, Constantine Plotnikov wrote:
>> >> Commit encoding is set correctly. The problem is that git log and git
>> >> show do not support the *output* encodings UTF-16 and UCS-4 and
>> >> silently fail in that case instead of reporting the error.
>> >
>> > That looks more like an iconv bug to me.  I assume you are using Windows?
>>
>> Iconv has no way to know that git cannot work with ASCII-incompatible
>> encodings, and UTF-16 is incompatible, because it fills the output with
>> loads of zero bytes. Git both truncates messages on these bytes, and
>> forgets inserting them in strings that it produces itself.
>
> Ah, I thought that the issue was that Git would not handle commits in that
> encoding correctly.  Instead, it appears that Git cannot work with UTF-16
> _displays_.

Actually, I think that using those encodings in commits is asking for
trouble too, because the encoding conversion is, as far as I remember,
applied to the entire contents of the commit object, and Git,
naturally, doesn't insert any null bytes in the commit headers to
please the decoder. The result is a completely trashed object on
output.

Also, I think that they are generally a poor choice of an encoding for
data transmission, because they are ASCII-incompatible,
stdlib-incompatible, unreliable to loss and addition of single bytes,
and have no way to detect encoding mismatch except by metadata or
heuristics: almost any string of shorts is "valid".

Alexander
