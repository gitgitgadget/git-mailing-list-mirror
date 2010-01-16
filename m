From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH v2 13/14] daemon: use select() instead of poll()
Date: Sat, 16 Jan 2010 10:26:29 +0100
Message-ID: <40aa078e1001160126q34bc066as3adb9b61eac690d@mail.gmail.com>
References: <1263591033-4992-1-git-send-email-kusmabite@gmail.com>
	 <40aa078e1001151508j208fa50boc5565a3be6bef893@mail.gmail.com>
	 <40aa078e1001151523o538b44c7x95def3447650eea4@mail.gmail.com>
	 <201001160906.26270.j6t@kdbg.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: msysgit@googlegroups.com, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sat Jan 16 10:26:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NW4vY-0005hE-6g
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jan 2010 10:26:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752703Ab0APJ0c convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 16 Jan 2010 04:26:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752694Ab0APJ0c
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jan 2010 04:26:32 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:54778 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752683Ab0APJ0b convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Jan 2010 04:26:31 -0500
Received: by ewy19 with SMTP id 19so1611708ewy.21
        for <git@vger.kernel.org>; Sat, 16 Jan 2010 01:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=fqGSbY2fhc1fU7CaXw/ZX0bwBF/BA0XtiBu/p+Tfw60=;
        b=L2QbnGLdblwyq1bwhdhUIrxtn+ROLb4/YAkXIJ8npiRvcVIz2nglcFdL+KbJErCpcl
         F09Axq2Dw16RP+LUvOFxDEC7jAdg2kbg2pmFrumh01dEFag9gGVoVsJImzoGPyz9unR6
         2//0Z6ckHrWYA0zEo5zbmEOY0d9FsKyI6UkGs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=cyCbaluVZSRxQQRKAKNPVd0t8pVIGfyLORduxnpgUR0bgNTwRT9yaac0kX8lx46oIU
         mrMjdy1qYxi7ifUgti3xPjbV15NxSBv5bTn3bbY3EeQq5F7lhhJzQ+0KU0qht5aXwUY0
         qB0hrqOg3YnemZqoaD9YVHJ3f3K6jswj6JUIc=
Received: by 10.216.87.6 with SMTP id x6mr1201212wee.174.1263633989608; Sat, 
	16 Jan 2010 01:26:29 -0800 (PST)
In-Reply-To: <201001160906.26270.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137213>

On Sat, Jan 16, 2010 at 9:06 AM, Johannes Sixt <j6t@kdbg.org> wrote:
> On Samstag, 16. Januar 2010, Erik Faye-Lund wrote:
>> +static inline void mingw_fd_set(int fd, fd_set *set)
>> +{
>> + =A0 =A0 FD_SET(_get_osfhandle(fd), set);
>> +}
>> =A0#undef FD_SET
>> +#define FD_SET(a,b) mingw_fd_set(a,b)
>> +
>> =A0#undef FD_ISSET
>> =A0#define FD_ISSET(fd, set) __WSAFDIsSet(_get_osfhandle(fd), (fd_se=
t
>> *)(set))
>
> Ah, yes, how obvious ;) You are going to do the same with FD_ISSET as=
 well,
> aren't you?
>
> -- Hannes
>

Do I really need to? There's already a single function for that, with
no "ugly hidden internals" there; __WSAFDIsSet() is documented in
MSDN. I mean, Sure... I could... I just don't see the point.

--=20
Erik "kusma" Faye-Lund
