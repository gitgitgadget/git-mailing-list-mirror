From: David Krmpotic <david.krmpotic@gmail.com>
Subject: auto merge bug
Date: Mon, 4 Mar 2013 17:46:48 +0100
Message-ID: <CAOFaZ+5F1BcWNU=AkcnS53bQt1VfAfsFjp9EvRCL=7kYiU1ejg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 04 17:47:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UCYY5-0008Nj-Vb
	for gcvg-git-2@plane.gmane.org; Mon, 04 Mar 2013 17:47:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757106Ab3CDQrL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Mar 2013 11:47:11 -0500
Received: from mail-wg0-f41.google.com ([74.125.82.41]:42687 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756760Ab3CDQrL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Mar 2013 11:47:11 -0500
Received: by mail-wg0-f41.google.com with SMTP id ds1so1614650wgb.4
        for <git@vger.kernel.org>; Mon, 04 Mar 2013 08:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=Z9+EbdZdqLsvmsK1osa/izKyobnKH8uRSyRdZORqcIs=;
        b=SXsYf2JOOb8737VC2oY+77TWY65FlD1r2Qj7UpBM2of+Y/aKx9QDG4+TGJ5geuh2z0
         vT0qoRA2hMQDlyTSnpVbjN3+wRxcs7im8fPcadj9MZt+n2HLstvhHa4OqctaBq1JOWUK
         NoiiaSj+UQouO6JMDARMlzg5+lElxBSiZff+PA+7+gdIckhC0TEabgqXtDFLb7/OX8Yu
         s85TRXURXkro07wokHGKWvne4bRQqUw6GPNm/YZ0qpD3Ukp0cyBBjuylszOv9/vdNaBf
         HAJZaP5UX8oSgdvdv0eBIn6oPJGmnqoaimbQ2g7wlmVWbbFpTcROZS6exUasjwZrlA+r
         GvXw==
X-Received: by 10.194.58.202 with SMTP id t10mr33580529wjq.4.1362415628322;
 Mon, 04 Mar 2013 08:47:08 -0800 (PST)
Received: by 10.194.143.70 with HTTP; Mon, 4 Mar 2013 08:46:48 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217402>

Hi!

We started working on a .NET app and the XML project file (.csproj)
got corrupted (a few closing tag missing).

79	     <Compile Include="SlovaricaForm.Designer.cs">
80	       <DependentUpon>SlovaricaForm.cs</DependentUpon>
81	+    <Compile Include="WebCamForm.cs">
82	+      <SubType>Form</SubType>
83	+    </Compile>
84	+    <Compile Include="WebCamForm.Designer.cs">
85	+      <DependentUpon>WebCamForm.cs</DependentUpon>
86	     </Compile>

between lines 80 and 81 there should be </Compile>

similarly:

121	     </EmbeddedResource>
122	     <EmbeddedResource Include="SlovaricaForm.resx">
123	       <DependentUpon>SlovaricaForm.cs</DependentUpon>
124	+    <EmbeddedResource Include="WebCamForm.resx">
125	+      <DependentUpon>WebCamForm.cs</DependentUpon>
126	     </EmbeddedResource>
127	     <EmbeddedResource Include="WordsSelectForm.resx">
128	       <DependentUpon>WordsSelectForm.cs</DependentUpon>

between 123 and 124 there is  </EmbeddedResource> missing.

The problematic commit is here:

https://github.com/davidhq/logo_x/commit/e3e5fa4b60b7939999b2a8c44330312755b72f93

it has two parents: ae2a364 and bd1a059

on both parents the project compiles in Visual Studio because
Logo.csproj is not corrupted.

How to reproduce and see that really there were no conflicts and the
file became corrupted:

C:\temp> git clone git@github.com:davidhq/logo_x.git
C:\temp\logo_x [master]> git checkout ae2a364
Note: checking out 'ae2a364'.

You are in 'detached HEAD' state. You can look around, make experimental
changes and commit them, and you can discard any commits you make in this
state without impacting any branches by performing another checkout.

If you want to create a new branch to retain commits you create, you may
do so (now or later) by using -b with the checkout command again. Example:

  git checkout -b new_branch_name

HEAD is now at ae2a364... general handler for letters
C:\temp\logo_x [(ae2a364...)]> git merge bd1a059
Auto-merging Logo/Logo.csproj
Merge made by the 'recursive' strategy.
 Logo/Logo.csproj            |   7 ++
 Logo/WebCamForm.Designer.cs |  88 +++++++++++++++++++
 Logo/WebCamForm.cs          | 209 ++++++++++++++++++++++++++++++++++++++++++++
 Logo/WebCamForm.resx        | 120 +++++++++++++++++++++++++
 Logo/WordsForm.Designer.cs  |   1 +
 Logo/WordsForm.cs           |   7 ++
 6 files changed, 432 insertions(+)
 create mode 100644 Logo/WebCamForm.Designer.cs
 create mode 100644 Logo/WebCamForm.cs
 create mode 100644 Logo/WebCamForm.resx

Now check Logo.csproj and observe line 81 (it should read </Compile>

If I add both missing closing tags the project compiles again.

Please investigate and thank you!

PS: on Windows I have version 1.8.0.msysgit.0 of git and on Mac I'm
not sure now, it's a bit older, but the same problem happens.

David
